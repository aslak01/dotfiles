return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip", lazy = true }, -- Also lazy-load snippets
  },
  lazy = true,
  event = "InsertEnter", -- Wait until typing
  config = function()
    -- Disable unused sources:
    require("cmp").setup {
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- Remove "buffer", "path" if unused
      },
    }
  end,
}
