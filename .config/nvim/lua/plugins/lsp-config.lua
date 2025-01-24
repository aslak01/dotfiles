return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", lazy = true },
  },
}
