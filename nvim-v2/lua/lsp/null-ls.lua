local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local is_in_current_folder = function()
  local file = vim.fn.expand("%:p:h")
  local pwd = vim.fn.getcwd()

  return vim.fn.stridx(file, pwd) >= 0
end

local enable_eslint = function(utils)
  return utils.root_has_file({ "node_modules/.bin/eslint" }) and is_in_current_folder
end

local enable_standardjs = function(utils)
  return utils.root_has_file({ "node_modules/.bin/standard" }) and is_in_current_folder
end

local enable_prettier = function(utils)
  return utils.root_has_file({ "node_modules/.bin/prettier" }) and is_in_current_folder
end

null_ls.setup({
    sources = {
        -- Diagnotics
        null_ls.builtins.diagnostics.eslint_d.with({
            condition = enable_eslint,
        }),
        null_ls.builtins.diagnostics.standardjs.with({
            condition = enable_standardjs,
        }),
        -- null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.staticcheck,

        -- Code actions
        null_ls.builtins.code_actions.eslint_d.with({
            condition = enable_eslint,
        }),

        -- Formating
        -- null_ls.builtins.formatting.rustfmt.with({
        --     condition = is_in_current_folder,
        -- }),
        -- null_ls.builtins.formatting.goimports.with({
        --     condition = is_in_current_folder,
        -- }),
        -- null_ls.builtins.formatting.golines.with({
        --     extra_args = { "-m", "80" },
        --     condition = is_in_current_folder,
        -- }),
        -- null_ls.builtins.formatting.clang_format.with({
        --     condition = is_in_current_folder,
        -- }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint_d.with({
            condition = enable_eslint,
        }),
        null_ls.builtins.formatting.standardjs.with({
            condition = enable_standardjs,
        }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
            },
            condition = enable_prettier,
        }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "css",
                "scss",
                "less",
                "html",
                "json",
                "jsonc",
                "yaml",
                "markdown",
                "markdown.mdx",
                "graphql",
            },
        }),
    },
    debug = false,
    -- on_attach = function(client, bufnr)
    -- 	if client.supports_method("textDocument/formatting") then
    -- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- 		vim.api.nvim_create_autocmd("BufWritePre", {
    -- 			group = augroup,
    -- 			buffer = bufnr,
    -- 			callback = function()
    -- 				vim.lsp.buf.format()
    -- 			end,
    -- 		})
    -- 	end
    -- end,
})
