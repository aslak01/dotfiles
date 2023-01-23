-- @keymaps
local keyset = vim.keymap.set

keyset("n", "<down>", "}")
keyset("n", "<up>", "{")
keyset("n", "<leader>q", ":bd<cr>")
keyset("n", "<leader>w", ":w<cr>")
keyset("n", "<C-space>", "/")
keyset("n", "<leader>d", vim.diagnostic.open_float)
keyset("n", "<leader>hh", vim.diagnostic.goto_prev)
keyset("n", "<leader>ll", vim.diagnostic.goto_next)
keyset("n", "<leader>fn", ":Telescope file_browser<CR>")

-- ripgrep
keyset("n", "<leader>rg", ":Rg<space>")

-- commentary
keyset("n", "<C-/>", ":Commentary<cr>")
keyset("v", "<C-/>", ":Commentary<cr>")

-- vim-test
keyset("n", "<leader>tn", ":TestNearest<cr>", { silent = true })
keyset("n", "<leader>tf", ":TestFile<cr>", { silent = true })
keyset("n", "<leader>ts", ":TestSuite<cr>", { silent = true })
keyset("n", "<leader>tl", ":TestLast<cr>", { silent = true })
keyset("n", "<leader>tv", ":TestVisit<cr>", { silent = true })

-- packer
keyset("n", "<leader>pi", ":PackerInstall<cr>")
keyset("n", "<leader>pu", ":PackerUpdate<cr>")
keyset("n", "<leader>pc", ":PackerClean<cr>")

-- fugitive
keyset("n", "<leader>gd", ":Gdiff<cr>")

-- telescope
keyset("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
keyset("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind [G]rep" })
keyset("n", "<leader>fs", require("telescope.builtin").git_status, { desc = "[F]ind [G]it status" })
keyset("n", "<leader>fh", require("telescope.builtin").oldfiles, { desc = "[F]ind [H]istory" })
keyset("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind [B]uffers" })
keyset("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind [W]ord" })
keyset("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
keyset("n", "<leader>fc", require("telescope.builtin").commands, { desc = "[F]ind [C]ommands" })

-- harpoon
keyset("n", "<leader>m", require("harpoon.mark").add_file)
keyset("n", "<leader>fm", ":Telescope harpoon marks<cr>")

-- lsp - set lsp mappings in callback
function SetCustomLspMappings(bufnr)
	keyset("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	keyset("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
	keyset("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
	keyset("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
	keyset("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
	keyset("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat current buffer" })

	keyset("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
	keyset("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
	keyset(
		"n",
		"<leader>ws",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ desc = "[W]orkspace [S]ymbols" }
	)

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format()
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })
end
