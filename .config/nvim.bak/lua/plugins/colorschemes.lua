---@type LazySpec
return {
  { "yorickpeterse/nvim-grey", lazy = false, priority = 1000 },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  -- past
  -- { "hauleth/blame.vim" },
  -- { "blazkowolf/gruber-darker.nvim" },
  -- { "rktjmp/lush.nvim" },
  -- { "mcchrish/zenbones.nvim" },

  -- {
  --   "wtfox/jellybeans.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("jellybeans").setup()
  --     vim.cmd.colorscheme "jellybeans"
  --   end,
  -- },
  -- {
  --   "wnkz/monoglow.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
}
