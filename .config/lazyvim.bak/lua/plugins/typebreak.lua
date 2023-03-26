return {
  "nagy135/typebreak.nvim",
  config = function()
    require("nvim-surround").setup({
      vim.keymap.set("n", "<leader>tb", require("typebreak").start, { desc = "Typebreak" }),
    })
  end,
}
