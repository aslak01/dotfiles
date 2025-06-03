return {
  "folke/snacks.nvim",
  opts = {
    notifier = { enabled = false },
    dashboard = {
      preset = {
        header = table.concat({
          "██    ██ ██ ███    ███",
          "██    ██ ██ ████  ████",
          "██    ██ ██ ██ ████ ██",
          " ██  ██  ██ ██  ██  ██",
          "  ████   ██ ██      ██",
        }, "\n"),
      },
    },
  },
}
