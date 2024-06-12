-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  { "AstroNvim/astrocommunity" },

  -- lang specific lsp etc
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },

  -- fortmatting and linting
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },

  -- misc lsp
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lspsaga-nvim" },

  -- sed
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.debugging.nvim-bqf" },

  -- orchestration
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- file system
  { import = "astrocommunity.file-explorer.oil-nvim" },

  -- github
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.openingh-nvim" },

  -- color
  { import = "astrocommunity.color.ccc-nvim" },
  { import = "astrocommunity.color.huez-nvim" },

  -- editor tweaks
  { import = "astrocommunity.editing-support.mini-splitjoin" },

  -- motion
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.before-nvim" },

  -- game
  { import = "astrocommunity.game.leetcode-nvim" },
}
