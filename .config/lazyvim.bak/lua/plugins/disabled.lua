return {
  -- disable noice
  -- { "folke/noice.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  -- not honoring root patterns, messing up deno
  -- https://github.com/LazyVim/LazyVim/issues/295
  -- https://github.com/folke/neoconf.nvim/issues/14
  { "folke/neoconf.nvim", enabled = false },
}
