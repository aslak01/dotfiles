local nls = require("null-ls")

local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

local U = {}
---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function U.fmt_on_save(client, buf)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = fmt_group,
			buffer = buf,
			callback = function()
				vim.lsp.buf.format({
					timeout_ms = 3000,
					buffer = buf,
				})
			end,
		})
	end
end

---Disable formatting for servers | Handled by null-ls
---@param client table
---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function U.disable_formatting(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = true
end

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
	sources = {
		----------------
		-- FORMATTING --
		----------------
		fmt.trim_whitespace.with({
			filetypes = { "text", "zsh", "toml", "make", "conf", "tmux" },
		}),
		-- NOTE:
		-- 1. both needs to be enabled to so prettier can apply eslint fixes
		-- 2. prettierd should come first to prevent occassional race condition
		fmt.prettierd,
		fmt.eslint_d,
		-- fmt.prettier.with({
		--     extra_args = {
		--         '--tab-width=4',
		--         '--trailing-comma=es5',
		--         '--end-of-line=lf',
		--         '--arrow-parens=always',
		--     },
		-- }),
		fmt.rustfmt,
		fmt.stylua,
		fmt.gofmt,
		fmt.zigfmt,
		fmt.shfmt.with({
			extra_args = { "-i", 4, "-ci", "-sr" },
		}),
		-----------------
		-- DIAGNOSTICS --
		-----------------
		-- dgn.eslint_d,
		dgn.shellcheck,
		------------------
		-- CODE ACTIONS --
		------------------
		cda.eslint_d,
		cda.shellcheck,
	},
	on_attach = function(client, bufnr)
		U.fmt_on_save(client, bufnr)
		U.disable_formatting(client)
	end,
})
