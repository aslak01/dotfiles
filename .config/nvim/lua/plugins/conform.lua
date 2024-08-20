---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      gotexttmpl = { "prettier" },
      gotmpl = { "prettier" },
      mustache = { "eslint_d" },
      handlebars = { "eslint_d" },
      json = { "prettier" },
      yaml = { "yamlfix" },
    },
  },
}
