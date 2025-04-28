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
    -- custom winbar
    local path_func =
      status.provider.filename { modify = ":.:h", fallback = "" }
    opts.winbar[1][1] =
      status.component.separated_path { path_func = path_func }
    opts.winbar[2] = {
      status.component.separated_path { path_func = path_func },
      status.component.file_info { -- add file_info to breadcrumbs
        file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
        file_read_only = false,
        file_modified = false,
        filename = {},
        filetype = false,
        hl = status.hl.get_attributes("winbar", true),
        surround = false,
        update = "BufEnter",
      },
      status.component.breadcrumbs {
        icon = { hl = true },
        hl = status.hl.get_attributes("winbar", true),
        prefix = true,
        padding = { left = 0 },
      },
    }
  end,
}
