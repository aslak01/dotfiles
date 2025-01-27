require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^v4",
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
    },
  },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- install = { colorscheme = { "astrodark", "habamax" } },
  defaults = { lazy = true },
  mason = {
    enable = true,
    dap = { enabled = false },
  },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
  ui = { backdrop = 100 },
} --[[@as LazyConfig]])
