-- @options
-- space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.cmdheight = 0 -- hide line below statusline
vim.o.background = "dark"
vim.o.backup = false
vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.history = 500
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.magic = true
vim.o.shiftwidth = 2
vim.o.showmatch = true
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.so = 7
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = -1 -- If negative, shiftwidth value is used
vim.o.timeoutlen = 500
vim.o.title = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmenu = true
vim.o.wildmode = "full"
vim.o.wrap = true
vim.o.writebackup = false
