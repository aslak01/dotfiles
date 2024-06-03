---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      handlebars = { "djlint" },
      mustache = { "djlint" }
    },
  }
}


