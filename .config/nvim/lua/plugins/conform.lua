---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      gotexttmpl = { "prettier" },
      mustache = { "prettier" },
      json = { "prettier" },
      yaml = { "yamlfix" },
    },
    ext_parsers = {
      mustache = "angular",
    },
  },
}
