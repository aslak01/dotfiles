---@type LazySpec
return {
  -- auto switching theme
  -- { "hauleth/blame.vim" },
  { "yorickpeterse/nvim-grey" },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  -- { "blazkowolf/gruber-darker.nvim" },
  -- { "rktjmp/lush.nvim" },
  -- { "mcchrish/zenbones.nvim" },
  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      require("auto-dark-mode").setup {
        update_interval = 3000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          -- vim.cmd "colorscheme blame"
          vim.cmd "colorscheme lackluster-hack"
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd "colorscheme grey"
        end,
      }
    end,
    init = function() require("auto-dark-mode").init() end,
  },

  -- {
  --   "wtfox/jellybeans.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("jellybeans").setup()
  --     vim.cmd.colorscheme "jellybeans"
  --   end,
  -- },
  -- {
  --   "wnkz/monoglow.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },

  -- {
  --   "tjdevries/ocaml.nvim",
  --   build = ":lua require('ocaml').update()",
  -- },
  -- -- http
  -- {
  --   "mistweaverco/kulala.nvim",
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, opts)
  --     -- customize the dashboard header
  --     opts.section.header.val = {
  --       "",
  --     }
  --     return opts
  --   end,
  -- },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- {
  --   "echasnovski/mini.surround",
  --   keys = {
  --     { "sa", desc = "Add surrounding", mode = { "n", "v" } },
  --     { "sd", desc = "Delete surrounding" },
  --     { "sf", desc = "Find right surrounding" },
  --     { "sF", desc = "Find left surrounding" },
  --     { "sh", desc = "Highlight surrounding" },
  --     { "sr", desc = "Replace surrounding" },
  --     { "sn", desc = "Update `MiniSurround.config.n_lines`" },
  --   },
  --   opts = { n_lines = 200 },
  -- },
}
