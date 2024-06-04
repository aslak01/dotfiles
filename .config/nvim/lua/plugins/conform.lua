---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      tmpl = { "prettier" },
      gotexttmpl = { "prettier" },
      handlebars = { "prettier" },
      mustache = { "prettier" },
    },
  }
}
