---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  opts = {
    auto_install = false,
    highlight = { enable = true },
  },
}
