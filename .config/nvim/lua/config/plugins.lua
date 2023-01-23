-- Netrw config (file explorer)
vim.g.netrw_banner = 1
vim.g.netrw_liststyle = 4
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_hide = 0

-- Startify config (start screen)
vim.g.startify_change_to_dir = 0
vim.g.startify_lists = {
	{ header = { ("   Recent Files in: " .. vim.fn.getcwd()) }, type = "dir" },
}

-- Telescope (fuzzy finder)
require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			mappings = {
				["i"] = {},
				["n"] = {},
			},
		},
	},
})
-- Harpoon (bookmarks manager)
require("harpoon").setup()
require("telescope").load_extension("harpoon")

-- Treesitter (syntax highlight)
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"bash",
		"json",
		"javascript",
		"typescript",
		"astro",
	},
	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Gitsigns (git icons)
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- Lualine (statusline)
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "gruvbox",
		component_separators = "|",
		section_separators = "",
	},
})

-- Floaterm
vim.g.floaterm_opener = "edit"
