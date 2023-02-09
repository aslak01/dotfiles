local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

-- @plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Coding plugins
	-- use("janko-m/vim-test") --  Run tests quickly

	-- Git plugins
	-- use("tpope/vim-fugitive") --  Git wrapper
	-- use("ruanyl/vim-gh-line") --  Open GitHub file at line
	-- use("junegunn/gv.vim") --  Git commit browser

	-- Utility plugins
	-- use("jremmen/vim-ripgrep") --  Grep on steroids
	use("ThePrimeagen/harpoon") --  Bookmark management
	-- use("junegunn/vim-peekaboo") --  Preview registers
	-- use("machakann/vim-highlightedyank") --  Highlight yanked text
	-- use("easymotion/vim-easymotion") --  Move fast

	-- Text manipulation plugins
	use("tpope/vim-surround") --  Surround text objects
	use("wellle/targets.vim") --  Additional text objects
	-- use("mg979/vim-visual-multi") --  Multiple cursors
	use("tpope/vim-commentary") --  Comment out code
	use("tpope/vim-repeat") --  Repeat commands
	use("tpope/vim-sleuth") --  Detect indentation
	-- use("tpope/vim-unimpaired") --  Pairs of handy bracket mappings
	use("junegunn/vim-easy-align") --  Align text
	-- use("raimondi/delimitmate") --  Auto closing quotes, brackets, etc
	use({
		"lukas-reineke/indent-blankline.nvim",
		confing = function()
			require("indent_blankline").setup({
				char = "┊",
				show_trailing_blankline_indent = false,
			})
		end,
	})

	-- UI plugins
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- })
	use("RRethy/nvim-base16")
	require('base16-colorscheme')
	-- use("mhinz/vim-startify") --  Custom start screen
	use("nvim-lualine/lualine.nvim") --  Fancy statusline
	use("lewis6991/gitsigns.nvim") --  Git signs
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing_function = "quadratic",
			})
		end,
	})
	use({ "nagy135/typebreak.nvim", requires = "nvim-lua/plenary.nvim" })

	-- File explorer plugins
	-- use("tpope/vim-vinegar")
	-- use("unblevable/quick-scope") --  Netrw extension
	-- use("voldikss/vim-floaterm") --  Floating terminal
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0", --  Fuzzy finder
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-file-browser.nvim") --  Fuzzy file browser

	require("telescope").load_extension("file_browser")

	-- Syntax plugins
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) --  Syntax highlighting

	-- LSP plugins
	-- use 'github/copilot.vim' --  AI code completion
	use("williamboman/mason.nvim") --  Easily install and manage LSP servers, DAP servers, linters, and formatters.
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			-- { "rafamadriz/friendly-snippets" },

			-- UI
			-- { "j-hui/fidget.nvim" },
		},
	})

	if is_bootstrap then
		require("packer").sync()
	end
end)

if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end
