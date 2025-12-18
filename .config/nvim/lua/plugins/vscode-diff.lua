---@type LazySpec
return {
  "esmuellert/vscode-diff.nvim",
  branch = "next",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>gD"
        opts.mappings.n[prefix] = { desc = "Diff" }
        opts.mappings.n[prefix .. "d"] =
          { "<Cmd>CodeDiff<CR>", desc = "Diff explorer" }
        opts.mappings.n[prefix .. "h"] =
          { "<Cmd>CodeDiff file HEAD<CR>", desc = "Diff with HEAD" }
      end,
    },
  },
  cmd = "CodeDiff",
}
