---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      gotexttmpl = { "prettier" },
      gotmpl = { "prettier" },
      mustache = { "eslint" },
      handlebars = { "eslint" },
      json = { "prettier" },
      yaml = { "yamlfix" },
    },
  },
}
