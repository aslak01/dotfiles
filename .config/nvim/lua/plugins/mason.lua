local OPAM_MAX_AGE_DAYS = 30

local function ensure_opam_fresh()
  if vim.fn.executable "opam" ~= 1 then return end
  local repo_marker = vim.fn.expand "~/.opam/repo/default/repo"
  local stat = vim.uv.fs_stat(repo_marker)
  if not stat then return end
  local age_days = (os.time() - stat.mtime.sec) / 86400
  if age_days < OPAM_MAX_AGE_DAYS then return end
  vim.notify(
    string.format("opam repo is %.0f days old; running `opam update` in background...", age_days),
    vim.log.levels.INFO
  )
  -- async so mason installs and the UI aren't blocked. Mason may proceed with
  -- slightly stale opam metadata; user can retry an opam-backed install after.
  vim.system({ "opam", "update" }, { text = true }, function(out)
    vim.schedule(function()
      if out.code ~= 0 then
        vim.notify("opam update failed:\n" .. (out.stderr or out.stdout or ""), vim.log.levels.WARN)
      else
        vim.notify("opam update complete", vim.log.levels.INFO)
      end
    end)
  end)
end

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      ensure_installed = {
        -- Make sure to use the names found in `:Mason`
        -- language servers
        "lua-language-server",

        -- linters
        "oxlint",

        -- formatters
        "stylua",

        -- debuggers
        -- "debugpy",

        -- other packages
        "tree-sitter-cli",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        desc = "Refresh stale opam repo before Mason installs",
        callback = ensure_opam_fresh,
      })
    end,
  },
}
