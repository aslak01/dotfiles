-- Cold start optimization: defer heavy operations
---@type LazySpec
return {
  -- Defer LSP setup until file is opened
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Defer completion until insert mode
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
  },

  -- Defer treesitter parsing until buffer is read
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Defer status line rendering
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
  },

  -- Defer file explorer
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { { "<leader>e", "<cmd>Oil<cr>", desc = "Oil" } },
  },

  -- Defer telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
  },

  -- Defer conform formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
  },
}