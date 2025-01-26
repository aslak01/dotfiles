---@type LazySpec
return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      -- vim.cmd "colorscheme blame"
      vim.cmd "colorscheme lackluster-hack"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      vim.cmd "colorscheme grey"
    end,
  },
}
