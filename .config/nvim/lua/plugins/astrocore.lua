-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local function yaml_ft(path, bufnr)
      local buf_text =
        table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
      if
        -- check if file is in roles, tasks, or handlers folder
        vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
        -- check for known ansible playbook text and if found, return yaml.ansible
        or vim.regex("hosts:\\|tasks:"):match_str(buf_text)
      then
        return "yaml.ansible"
      elseif vim.regex("AWSTemplateFormatVersion:"):match_str(buf_text) then
        return "yaml.cfn"
      else -- return yaml if nothing else
        return "yaml"
      end
    end
    opts = require("astrocore").extend_tbl(opts, {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = false, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
        highlighturl = false, -- highlight URLs at start
        notifications = false, -- enable notifications at start
      },
      -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        update_in_insert = false,
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      },
      filetypes = {
        extension = {
          mdx = "markdown.mdx",
          nf = "nextflow",
          ["nf.test"] = "nextflow",
          qmd = "markdown",
          yaml = yaml_ft,
          yml = yaml_ft,
        },
        filename = {
          ["docker-compose.yaml"] = "yaml.docker-compose",
          ["docker-compose.yml"] = "yaml.docker-compose",
        },
        pattern = {
          ["%.env%.[%w_.-]+"] = "sh",
          [".*%.pkr%.hcl"] = "hcl.packer",
          [".*zsh/%..*"] = "zsh",
          ["/tmp/neomutt.*"] = "markdown",
        },
      },
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          conceallevel = 1, -- enable conceal
          relativenumber = true, -- sets vim.opt.relativenumber
          number = true, -- sets vim.opt.number
          spell = false, -- sets vim.opt.spell
          signcolumn = "yes", -- sets vim.opt.signcolumn to auto
          scrolloff = 8,
          wrap = false, -- sets vim.opt.wrap
          showtabline = 0,
          list = true, -- show whitespace characters (working?)
          listchars = {
            tab = "│→",
            extends = "⟩",
            precedes = "⟨",
            trail = "·",
            nbsp = "␣",
          },
          showbreak = "↪ ",
          colorcolumn = "80",
          swapfile = false,
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
    } --[[@as AstroCoreOpts]]) --[[@as AstroCoreOpts]]
    return opts
  end,
}
