---@type LazySpec
return {
  "rebelot/heirline.nvim",
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        status = {
          attributes = { mode = { bold = true } },
        },
      },
    },
  },
  opts = function(_, opts)
    local status = require "astroui.status"
    -- simplified winbar - remove expensive separated_path and breadcrumbs
    local file_info = status.component.file_info {
      filename = { modify = ":t" }, -- just filename, not full path
      filetype = false,
      file_read_only = false,
      hl = status.hl.get_attributes("winbar", true),
      surround = false,
      update = "BufEnter",
    }
    opts.winbar[1][1] = file_info
    table.remove(opts.winbar[1], 2)
    opts.winbar[2] = { file_info }
  end,
}
