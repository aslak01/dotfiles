return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "BufReadPre",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", lazy = true },
  },
}
