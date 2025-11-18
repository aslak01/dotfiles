-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      diagnostics = { virtual_lines = false },
    },
    diagnostics = {
      update_in_insert = false,
      virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      virtual_lines = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.WARN },
      },
    },
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        yaml = "yaml",
        yml = "yaml",
        pkl = "pkl",
        pcf = "pkl",
        gohtml = "gotmpl",
      },
      filename = {
        ["PklProject"] = "pkl",
      },
      pattern = {
        ["%.env%.[%w_.-]+"] = "sh",
        [".*%.pkr%.hcl"] = "hcl.packer",
        [".*zsh/%..*"] = "zsh",
        ["/tmp/neomutt.*"] = "markdown",
      },
    },
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        scrolloff = 8,
        wrap = false,
        showtabline = 0,
        colorcolumn = "80",
        swapfile = false,
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        list = true, -- show whitespace characters (working?)
        listchars = {
          tab = "│→",
          extends = "⟩",
          precedes = "⟨",
          trail = "·",
          nbsp = "␣",
        },
        showbreak = "↪ ",
      },
      g = { -- vim.g.<key>
      },
    },
    commands = {
      MessagesCopy = {
        function() vim.cmd "redir @+ | messages | redir END" end,
        desc = "Copy messages to clipboard",
      },
    },
    autocmds = {
      auto_spell = {
        {
          event = "FileType",
          desc = "Enable wrap and spell for text like documents",
          pattern = { "gitcommit", "markdown", "text", "plaintex" },
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end,
        },
      },
      -- auto_background_switch = {
      --   {
      --     event = "OptionSet",
      --     pattern = "background",
      --     desc = "Switch colorscheme based on terminal background",
      --     callback = function()
      --       local bg = vim.o.background
      --       if bg == "dark" then
      --         vim.cmd.colorscheme("lackluster-hack")
      --       else
      --         vim.cmd.colorscheme("grey")
      --       end
      --     end,
      --   },
      -- },
    },
    mappings = {
      n = {
        ["<Leader>e"] = { "<cmd>Oil<cr>", desc = "Oil" },
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>mc"] = { "<cmd>MessagesCopy<cr>", desc = "Copy messages to clipboard" },
      },
    },
  },
}
