---@type LazySpec
return {
  dir = "~/w/pers/typebreak.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "grapp-dev/nui-components.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
  },
  keys = {
    {
      "<leader>tb",
      "<cmd>:lua require('typebreak').start(true)<cr>",
      desc = "typebreak",
    },
  },
}
