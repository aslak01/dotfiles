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

  { import = "astrocommunity.editing-support.conform-nvim" },

  -- general lsp
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- orchestration
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- file system
  { import = "astrocommunity.file-explorer.oil-nvim" },

  -- github
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.openingh-nvim" },

  -- color
  { import = "astrocommunity.color.ccc-nvim" },

  -- editor tweaks
  { import = "astrocommunity.editing-support.mini-splitjoin" },
}
