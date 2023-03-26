-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- remove keybinds I don't like:
local del = vim.keymap.del
del("n", "<leader>l")

-- add keybinds I want, or modify existing to work for me
local set = vim.keymap.set

set("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })

-- local silicon = require("silicon")
--
-- set("v", "<Leader>s", function()
--   silicon.visualise_api()
-- end)
-- set("v", "<Leader>bs", function()
--   silicon.visualise_api({ to_clip = true, show_buf = true })
-- end)
-- -- Generate visible portion of a buffer
-- set("n", "<Leader>s", function()
--   silicon.visualise_api({ to_clip = true, visible = true })
-- end)
-- -- Generate current buffer line in normal mode
-- set("n", "<Leader>s", function()
--   silicon.visualise_api({ to_clip = true })
-- end)
