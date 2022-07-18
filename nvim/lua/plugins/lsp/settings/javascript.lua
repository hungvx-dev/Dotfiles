-- local lspconfig = require 'lspconfig'
-- local default_key = require 'plugins/lsp/default'
-- local TSPrebuild = {}

-- TSPrebuild.on_attach = function(client, bufnr)
--   if has_prebuilt then return end

--   local query = require 'vim.treesitter.query'

--   local function safe_read(filename, read_quantifier)
--     local file, err = io.open(filename, "r")
--     if not file then error(err) end
--     local content = file:read(read_quantifier)
--     io.close(file)
--     return content
--   end

--   local function read_query_files(filenames)
--     local contents = {}

--     for _, filename in ipairs(filenames) do table.insert(contents, safe_read(filename, "*a")) end

--     return table.concat(contents, "")
--   end

--   local function prebuild_query(lang, query_name)
--     local query_files = query.get_query_files(lang, query_name)
--     local query_string = read_query_files(query_files)

--     query.set_query(lang, query_name, query_string)
--   end

--   local prebuild_languages = {"typescript", "javascript", "tsx", "vue"}
--   for _, lang in ipairs(prebuild_languages) do
--     prebuild_query(lang, "highlights")
--     prebuild_query(lang, "injections")
--   end
--   has_prebuilt = true
-- end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lspconfig.tsserver.setup({
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     TSPrebuild.on_attach(client, bufnr)
--     if client.config.flags then client.config.flags.allow_incremental_sync = true end
--     client.server_capabilities.document_formatting = true
--     if client.server_capabilities.document_formatting then
--       vim.cmd([[
--       augroup LspFormatting
--       autocmd! * <buffer>
--       autocmd BufWritePre <buffer> EslintFixAll
--       augroup END
--       ]])
--       -- vim.cmd([[
--       -- augroup LspFormatting
--       -- autocmd! * <buffer>
--       -- autocmd BufWritePre <buffer> PrettierAsync
--       -- augroup END
--       -- ]])
--     end
--     -- no default maps, so you may want to define some here
--     default_key(client, bufnr)
--   end,
--   filetypes = {"typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx"},
--   root_dir = function()
--     return vim.fn.getcwd()
--   end
-- })

-- -- lspconfig.eslint.setup({
-- --   cmd = {"vscode-eslint-language-server", "--stdio"},
-- --   filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"},
-- --   init_options = {documentFormatting = true},
-- --   capabilities = capabilities,
-- --   settings = {
-- --     codeAction = {disableRuleComment = {enable = true, location = "separateLine"}, showDocumentation = {enable = true}},
-- --     codeActionOnSave = {enable = true, mode = "all"},
-- --     format = true,
-- --     onIgnoredFiles = "off",
-- --     packageManager = "npm",
-- --     quiet = false,
-- --     run = "onType",
-- --     useESLintClass = false,
-- --     validate = "on",
-- --     workingDirectory = {mode = "location"}
-- --   }
-- -- })
