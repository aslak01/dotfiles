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
      -- AlignColumns = {
      --   function(opts)
      --     local range = opts.range > 0 and opts.line1 .. "," .. opts.line2 or "%"
      --     local foldmethod = vim.wo.foldmethod
      --     vim.wo.foldmethod = "manual"
      --     vim.cmd("silent " .. range .. [=[!awk '/^[[:space:]]*[#]/{print"@@"$0;next}1' | column -t | sed 's/^@@//']=])
      --     vim.schedule(function() vim.wo.foldmethod = foldmethod end)
      --   end,
      --   range = true,
      --   desc = "Align columns preserving comments",
      -- },
      AlignColumns = {
        function(opts)
          local start_line = opts.range > 0 and opts.line1 or 1
          local end_line = opts.range > 0 and opts.line2 or vim.api.nvim_buf_line_count(0)

          local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

          -- Get comment prefix from commentstring (e.g., "# %s" -> "#", "// %s" -> "//")
          local cs = vim.bo.commentstring
          local prefix = cs:match "^(.-)%%s" or "#"
          prefix = vim.trim(prefix)
          -- Escape Lua pattern special characters
          local escaped_prefix = prefix:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")

          -- Separate data lines from comments/empty lines
          local data_lines = {}
          local is_data = {}

          for i, line in ipairs(lines) do
            if line:match("^%s*" .. escaped_prefix) or line:match "^%s*$" then
              is_data[i] = false
            else
              is_data[i] = true
              table.insert(data_lines, line)
            end
          end

          -- Run column -t on all data lines together
          local aligned_lines = {}
          if #data_lines > 0 then
            local input = table.concat(data_lines, "\n") .. "\n"
            local output = vim.fn.system("column -t 2>/dev/null", input)
            output = output:gsub("\n$", "")
            aligned_lines = vim.split(output, "\n", { plain = true })
          end

          -- Reassemble with comments/empty lines in original positions
          local result = {}
          local aligned_idx = 1
          for i, line in ipairs(lines) do
            if is_data[i] then
              table.insert(result, aligned_lines[aligned_idx] or line)
              aligned_idx = aligned_idx + 1
            else
              table.insert(result, line)
            end
          end

          vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
        end,
        range = true,
        desc = "Align columns preserving comments",
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
        ["<Leader>aa"] = {
          "<cmd>AlignColumns<cr>",
          desc = "Align columns",
        },
      },
      x = {
        ["<Leader>aa"] = {
          ":'<,'>AlignColumns<cr>",
          desc = "Align columns",
        },
      },
    },
  },
}
