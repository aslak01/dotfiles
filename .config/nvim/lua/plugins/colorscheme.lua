---@type LazySpec
return {
  -- {
  --   "stevedylandev/ansi-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd "colorscheme ansi"
  --     vim.opt.termguicolors = false
  --   end,
  -- },
  { "yorickpeterse/nvim-grey", lazy = false, priority = 1000 },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd "colorscheme lackluster-hack"
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd "colorscheme grey"
      end,
    },
  },
}
