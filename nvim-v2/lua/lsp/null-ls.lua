local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
local completions = null_ls.builtins.completion

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier
null_ls.setup({
	debug = false,
	sources = {

		-- Formatting
		formatting.prettier.with({
			-- extra_filetypes = { "toml", "solidity" },
			-- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.eslint_d.with({ extra_args = { "--no-ignore" } }), -- prettier, eslint, eslint_d, or prettierd
		formatting.stylua,
		-- formatting.codespell,

		-- Fiagnotics
		diagnostics.shellcheck,
		diagnostics.codespell,
		diagnostics.eslint_d, -- eslint or eslint_d

		-- Actions
		actions.eslint_d,

		-- Completions
		-- completions.spell,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = true })
				end,
			})
		end
	end,
})
