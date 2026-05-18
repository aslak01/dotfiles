-- Early initialization optimizations for cold start performance
-- This file is loaded before lazy.nvim to optimize startup

-- Disable unnecessary providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

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