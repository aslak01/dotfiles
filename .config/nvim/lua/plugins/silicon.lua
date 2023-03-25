return {
  "narutoxy/silicon.nvim",
  config = function()
    require("silicon").setup({
      font = "Liga SFMono Nerd Font=14",
      theme = "Lunaperche",
      output = "~/Downloads/SILICON_${year}-${month}-${date}_${time}.png",
    })
  end,
  keys = {
    -- Generate image of lines in a visual selection
    { "<Leader>SS", "function() silicon.visualise_api() end", desc = "Silicon visual selection ss" },
    -- -- Generate image of a whole buffer, with lines in a visual selection highlighted
    -- vim.keymap.set('v', '<Leader>bs', function() silicon.visualise_api({to_clip = true, show_buf = true}) end )
    -- -- Generate visible portion of a buffer
    -- vim.keymap.set('n', '<Leader>s',  function() silicon.visualise_api({to_clip = true, visible = true}) end )
    -- -- Generate current buffer line in normal mode
    -- vim.keymap.set('n', '<Leader>s',  function() silicon.visualise_api({to_clip = true}) end )
  },
}
