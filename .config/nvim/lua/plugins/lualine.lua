return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = {
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    }
  end,
}
