---@type LazySpec
return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "bufreadpre "
      .. vim.fn.expand "~"
      .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/obs",
      },
      {
        name = "tnr",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Tnr",
      },
    },
  },
}
