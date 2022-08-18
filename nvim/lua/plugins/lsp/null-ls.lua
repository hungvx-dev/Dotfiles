local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local action = null_ls.builtins.code_actions
local sources = {
	formatting.stylua,
	formatting.prettier.with({
		extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
	}),
	formatting.eslint_d.with({
		extra_args = { "--no-ignore" },
	}), -- prettier, eslint, eslint_d, or prettierd
	diagnostics.eslint_d, -- eslint or eslint_d
	null_ls.builtins.completion.spell,
	action.eslint_d, -- eslint or eslint_d
}

null_ls.setup({
	autostart = true,
	sources = sources,
	on_attach = function(client)
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- end
	end,
})
