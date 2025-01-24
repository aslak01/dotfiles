---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "User AstroFile",
  version = vim.fn.has "nvim-0.10" ~= 1 and "7",
  cmd = "ConformInfo",
  dependencies = { "williamboman/mason.nvim" },
  ---@param opts conform.setupOpts
  opts = function(_, opts)
    local buf_utils = require "astrocore.buffer"
    opts.default_format_opts = { lsp_format = "fallback" }

    opts.format_on_save = function(bufnr)
      if vim.g.autoformat == nil then vim.g.autoformat = true end
      local autoformat = vim.b[bufnr].autoformat
      if autoformat == nil then autoformat = vim.g.autoformat end
      if autoformat then return { timeout_ms = 2000 } end
    end

    opts.formatters_by_ft = {
      ["*"] = function(bufnr)
        return buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) and { "injected" } or {}
      end,
      toml = { "taplo" },
      lua = { "stylua" },
      sh = { "shfmt" },
    }

    -- prettier filetypes
    vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "prettierd" } end, {
      "css",
      "scss",
      "svg",
      "html",
      "json",
      "jsonc",
      "yaml",
      "yaml.ansible",
      "yaml.cfn",
      "markdown",
      "markdown.mdx",
      "gotmpl",
    })

    vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "biome" } end, {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    })

    opts.formatters = {
      prettier = {
        options = {
          ft_parsers = {
            markdown = "markdown",
            svg = "html",
            html = "html",
          },
        },
      },
    }
  end,
}
