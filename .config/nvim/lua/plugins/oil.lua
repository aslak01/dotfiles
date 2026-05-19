local git_status_cache = {}

local function clear_git_status_cache(dir)
  if dir then
    git_status_cache[dir] = nil
  else
    for k in pairs(git_status_cache) do
      git_status_cache[k] = nil
    end
  end
end

---@type LazySpec
return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0) --[[@as string]])
      if stat and stat.type == "directory" then require("lazy").load { plugins = { "oil.nvim" } } end
    end
  end,
  opts = function(_, opts)
    local astrocore, get_icon = require "astrocore", require("astroui").get_icon

    local function parse_output(commands)
      local result, ret = astrocore.cmd(commands, false), {}
      if result then
        for line in vim.gsplit(result, "\n", { plain = true, trimempty = true }) do
          ret[line:gsub("/$", "")] = true
        end
      end
      return ret
    end

    local function get_git_status(dir)
      if not git_status_cache[dir] then
        local git_avail = vim.fn.executable "git" == 1
        if git_avail then
          local ignore_cmd =
            { "git", "-C", dir, "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }
          local tracked_cmd = { "git", "-C", dir, "ls-tree", "HEAD", "--name-only" }
          git_status_cache[dir] = {
            ignored = parse_output(ignore_cmd),
            tracked = parse_output(tracked_cmd),
          }
        else
          git_status_cache[dir] = { ignored = {}, tracked = {} }
        end
      end
      return git_status_cache[dir]
    end

    local view_options = {
      is_hidden_file = function(name, bufnr)
        local dir = require("oil").get_current_dir(bufnr)
        local is_hidden = vim.startswith(name, ".") and name ~= ".."
        if vim.fn.executable "git" ~= 1 or not dir then return is_hidden end
        local status = get_git_status(dir)
        if is_hidden then
          return not status.tracked[name]
        else
          return status.ignored[name]
        end
      end,
      is_always_hidden = function(name) return name == ".." end,
    }

    local columns = {
      icon = {
        "icon",
        default_file = get_icon "DefaultFile",
        directory = get_icon "FolderClosed",
      },
      permissions = { "permissions", highlight = "Type" },
      size = { "size", highlight = "String" },
      mtime = { "mtime", highlight = "Function" },
    }
    local simple, detailed = { columns.icon }, { columns.permissions, columns.size, columns.mtime, columns.icon }

    return astrocore.extend_tbl(opts, {
      columns = simple,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      watch_for_changes = true,
      keymaps = {
        gd = {
          desc = "Toggle detailed file view",
          callback = function() require("oil").set_columns(#require("oil.config").columns == 1 and detailed or simple) end,
        },
        R = {
          desc = "Refresh (also clears git status cache)",
          callback = function()
            clear_git_status_cache(require("oil").get_current_dir())
            require("oil.actions").refresh.callback()
          end,
        },
        H = "actions.toggle_hidden",
        -- Disable all default Ctrl keybindings to prevent conflicts with split navigation
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-p>"] = false,
        ["<C-c>"] = false,
        ["<C-l>"] = false,
      },
      lsp_file_methods = { autosave_changes = "unmodified" },
      view_options = view_options,
      preview_win = {
        win_options = {
          foldcolumn = "0",
          number = false,
          relativenumber = false,
          signcolumn = "no",
        },
      },
    } --[[ @type oil.setupOpts ]])
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          neotree_start = false,
          oil_settings = {
            {
              event = "FileType",
              desc = "Disable view saving for oil buffers",
              pattern = "oil",
              callback = function(args) vim.b[args.buf].view_activated = false end,
            },
          },
          oil_invalidate_git_cache = {
            {
              event = "FocusGained",
              desc = "Invalidate oil git status cache when returning to nvim",
              callback = function() clear_git_status_cache() end,
            },
          },
        },
      },
    },

    {
      "AstroNvim/astroui",
      opts = { status = { winbar = { enabled = { filetype = { "^oil$" } } } } },
    },
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts)
        if opts.winbar then
          local status = require "astroui.status"
          table.insert(opts.winbar, 1, {
            condition = function(self) return status.condition.buffer_matches({ filetype = "^oil$" }, self.bufnr) end,
            status.component.separated_path {
              padding = { left = 2 },
              max_depth = 0,
              suffix = false,
              path_func = function(self) return require("oil").get_current_dir(self.bufnr) or "" end,
            },
          })
        end
      end,
    },
  },
}
