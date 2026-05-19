local lint -- cache for the nvim-lint package

-- Extend nvim-lint's Linter type with our custom `condition` field, used by
-- the patched `_resolve_linter_by_ft` below to skip linters whose project
-- root is missing the relevant config file.
---@class lint.Linter
---@field condition? fun(ctx: { filename: string, dirname: string }): boolean

---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = "User AstroFile",
  dependencies = { "mason-org/mason.nvim" },
  specs = {
    { "jay-babu/mason-null-ls.nvim", optional = true, opts = { methods = { diagnostics = false } } },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local timer = assert((vim.uv or vim.loop).new_timer())
        if not opts.autocmds then opts.autocmds = {} end
        opts.autocmds.auto_lint = {
          {
            event = { "BufWritePost", "BufReadPost" },
            desc = "Automatically lint with nvim-lint",
            callback = function()
              -- only run autocommand when nvim-lint is loaded
              if lint then
                timer:start(100, 0, function()
                  timer:stop()
                  vim.schedule(lint.try_lint)
                end)
              end
            end,
          },
        }
      end,
    },
  },
  opts = {
    linters_by_ft = {
      javascript = { "oxlint", "biomejs" },
      javascriptreact = { "oxlint", "biomejs" },
      typescript = { "oxlint", "biomejs" },
      typescriptreact = { "oxlint", "biomejs" },
      css = { "biomejs" },
      make = { "checkmake" },
    },
    linters = {
      oxlint = {
        condition = function(ctx)
          local rooter = require "astrocore.rooter"
          local bufnr = vim.fn.bufnr(ctx.filename)
          local roots = rooter.detect(bufnr, false) -- false = just get first root

          if not roots or #roots == 0 then return false end

          -- Check if .oxlintrc.json exists in the detected project root
          local project_root = roots[1].paths[1]
          if project_root then
            local config_file = vim.fs.joinpath(project_root, ".oxlintrc.json")
            return vim.fn.filereadable(config_file) == 1
          end

          return false
        end,
      },
      biomejs = {
        cmd = function()
          local rooter = require "astrocore.rooter"
          local bufnr = vim.api.nvim_get_current_buf()
          local roots = rooter.detect(bufnr, false)

          if roots and #roots > 0 then
            local project_root = roots[1].paths[1]
            -- Try node_modules/.bin/biome first (local installation)
            local local_biome = vim.fs.joinpath(project_root, "node_modules", ".bin", "biome")
            if vim.fn.executable(local_biome) == 1 then return local_biome end
          end

          -- Fallback to global biome
          return "biome"
        end,
        condition = function(ctx)
          local rooter = require "astrocore.rooter"
          local bufnr = vim.fn.bufnr(ctx.filename)
          local roots = rooter.detect(bufnr, false) -- false = just get first root

          if not roots or #roots == 0 then return false end

          -- Check if biome.json exists in the detected project root
          local project_root = roots[1].paths[1]
          if project_root then
            local config_file = vim.fs.joinpath(project_root, "biome.json")
            return vim.fn.filereadable(config_file) == 1
          end

          return false
        end,
      },
    },
  },
  config = function(_, opts)
    local astrocore = require "astrocore"
    lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft or {}
    for name, linter in pairs(opts.linters or {}) do
      local base = lint.linters[name]
      lint.linters[name] = (type(linter) == "table" and type(base) == "table")
          and vim.tbl_deep_extend("force", base, linter)
        or linter
    end

    local valid_linters = function(ctx, linters)
      if not linters then return {} end
      return vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then return false end
        local cmd = linter.cmd
        if type(cmd) == "function" then cmd = cmd() end
        if type(cmd) ~= "string" or vim.fn.executable(cmd) ~= 1 then return false end
        if linter.condition and not linter.condition(ctx) then return false end
        return true
      end, linters)
    end

    -- Patches nvim-lint's internal `_resolve_linter_by_ft` (private API) so we can
    -- filter linters by executable + per-linter `condition`. Revisit if nvim-lint
    -- exposes a public hook or renames this function.
    lint._resolve_linter_by_ft = astrocore.patch_func(lint._resolve_linter_by_ft, function(orig, ...)
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

      local linters = valid_linters(ctx, orig(...))
      if not linters[1] then linters = valid_linters(ctx, lint.linters_by_ft["_"]) end -- fallback
      astrocore.list_insert_unique(linters, valid_linters(ctx, lint.linters_by_ft["*"])) -- global

      return linters
    end)

    lint.try_lint()
  end,
}
