-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.filetype.add {
  extension = {
    mustache = "handlebars",
    tmpl = "gotmpl",
  },
  filename = {
    -- ["Foofile"] = "fooscript",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- TODO: remove when filetypes are cleaned up in go.nvim
-- vim.treesitter.language.register("gotmpl", "gotexttmpl")
