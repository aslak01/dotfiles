return {
  "nvim-neotest/neotest",
  dependencies = { "thenbe/neotest-playwright" },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(
      opts.adapters,
      require("neotest-playwright").adapter {
        options = {
          persist_project_selection = true,
          enable_dynamic_test_discovery = true,
        },
      }
    )
  end,
}
