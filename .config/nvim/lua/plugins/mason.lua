---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
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
  },
}
