if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- -- Keep the cursorline at the center of the window
-- author: AshenCone
--
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      center_cursorline = {
        {
          event = { "BufNewFile", "BufReadPost", "BufWritePost" },
          desc = "Keeps the cursorline at the center of the screen [1]",
          callback = function(args)
            -- add the virtual lines at the top
            local win_height = vim.api.nvim_win_get_height(0) - 1 -- 1 row is taken up by winbar
            local win_offset = math.floor(win_height / 2)
            local extmark_ns = vim.api.nvim_create_namespace "center_cursorline_padding"

            local virt_lines = {}
            for _ = 1, win_offset do
              table.insert(virt_lines, { { "", "" } })
            end
            vim.api.nvim_buf_set_extmark(0, extmark_ns, 0, 0, {
              id = 1,
              virt_lines = virt_lines,
              virt_lines_above = true,
              right_gravity = false,
              priority = 0,
            })

            -- add autocmd to trigger on cursor movement
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              desc = "Keeps the cursorline at the center of the screen [2]",
              callback = function()
                local current_line = vim.api.nvim_win_get_cursor(0)[1]

                -- PERF: avoid recalculations if the cursorline has not changed
                if current_line == vim.b[args.buf].center_cursorline_last_line then return end
                vim.b[args.buf].center_cursorline_last_line = current_line

                local win_view = vim.fn.winsaveview()
                win_view.topline = math.max(current_line - win_offset, 1)
                win_view.topfill = math.max(win_offset - current_line + 1, 0)
                vim.fn.winrestview(win_view)
              end,
              buffer = args.buf,
              group = vim.api.nvim_create_augroup("center_cursorline_cursormoved" .. args.buf, { clear = true }),
            })

            -- add autocmd to trigger when entereing a buffer
            -- BufWinEnter is a bit more reliable than BufEnter to trigger on the initial load
            vim.api.nvim_create_autocmd("BufWinEnter", {
              desc = "Keeps the cursorline at the center of the screen [2]",
              callback = function()
                -- nvim_win_get_cursor is unreliable on the first frame (vim.schedule works but slow and flashes the screen)
                -- so we load the last known line if it exists
                local current_line = vim.b[args.buf].center_cursorline_last_line or vim.api.nvim_win_get_cursor(0)[1]

                -- we always want to center the cursorline when a buffer changes
                vim.b[args.buf].center_cursorline_last_line = current_line

                local win_view = vim.fn.winsaveview()
                win_view.topline = math.max(current_line - win_offset, 1)
                win_view.topfill = math.max(win_offset - current_line + 1, 0)
                vim.fn.winrestview(win_view)
              end,
              buffer = args.buf,
              group = vim.api.nvim_create_augroup("center_cursorline_bufenter" .. args.buf, { clear = true }),
            })
          end,
        },
      },
    },
  },
}
