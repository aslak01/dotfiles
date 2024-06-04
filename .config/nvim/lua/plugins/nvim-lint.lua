---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      handlebars = { "djlint", "eslint-lsp" },
      mustache = { "djlint", "eslint-lsp" }
    },
  }
}


