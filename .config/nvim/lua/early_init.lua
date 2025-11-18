-- Early initialization optimizations for cold start performance
-- This file is loaded before lazy.nvim to optimize startup

-- Disable unnecessary providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- Disable some built-in plugins early
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1

-- Optimize vim loader for faster require()
vim.loader.enable()

-- Set minimal options early
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Defer shada reading until after startup
vim.opt.shada = ""
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.shada = "!,'100,<50,s10,h"
    pcall(vim.cmd.rshada, { bang = true })
  end,
})