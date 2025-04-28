-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  --@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
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
        -- conceallevel = 1,
      },
    },
    -- Configure core features of AstroNvim
    features = {
      diagnostics = { virtual_lines = false },
      -- autopairs = false, -- enable autopairs at start
      -- cmp = true, -- enable completion at start
      -- diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      -- highlighturl = false, -- highlight URLs at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      update_in_insert = false,
      virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      virtual_lines = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.WARN },
      },
    },
    filetypes = {
      extension = {
        mdx = "markdown.mdx",
        nf = "nextflow",
        ["nf.test"] = "nextflow",
        qmd = "markdown",
        yaml = "yaml",
        yml = "yaml",
        pkl = "pkl",
        pcf = "pkl",
      },
      filename = {
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["PklProject"] = "pkl",
      },
      pattern = {
        ["%.env%.[%w_.-]+"] = "sh",
        [".*%.pkr%.hcl"] = "hcl.packer",
        [".*zsh/%..*"] = "zsh",
        ["/tmp/neomutt.*"] = "markdown",
      },
    },
    signs = {
      BqfSign = {
        text = " " .. require("astroui").get_icon "Selected",
        texthl = "BqfSign",
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
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["<Leader>e"] = { "<cmd>Oil<cr>", desc = "Oil" },
      },
      i = {
        -- hacking in support for norwegian letters in insert mode
        ["<M-'>"] = "æ",
        ['<M-">'] = "Æ",
        ["<M-o>"] = "ø",
        ["<M-O>"] = "Ø",
        ["<M-a>"] = "å",
        ["<M-A>"] = "Å",
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
