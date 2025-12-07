-- this file is imported `lazy_setup.lua` before `plugins/`
-- so the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go", ft = "go" },
  { import = "astrocommunity.pack.bash", ft = { "bash", "sh", "zsh" } },
  { import = "astrocommunity.pack.python-ruff", ft = "python" },
  { import = "astrocommunity.pack.yaml", ft = { "yaml", "yml" } },
  { import = "astrocommunity.pack.markdown", ft = "markdown" },
  {
    import = "astrocommunity.pack.typescript",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  { import = "astrocommunity.pack.svelte", ft = "svelte" },
  { import = "astrocommunity.markdown-and-latex.markview-nvim", ft = "markdown" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.pack.html-css", ft = { "html", "css" } },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.test.neotest", cmd = "Neotest" },
  { import = "astrocommunity.pack.ocaml", ft = "ocaml" },
  { import = "astrocommunity.pack.gleam", ft = "gleam" },
  { import = "astrocommunity.pack.pkl", ft = "pkl" },
  { import = "astrocommunity.snippet.mini-snippets" },
  { import = "astrocommunity.search.grug-far-nvim" },
}
