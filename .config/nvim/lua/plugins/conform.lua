---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      handlebars = { "djlint" },
      mustache = { "djlint" }
    },
  }
}
