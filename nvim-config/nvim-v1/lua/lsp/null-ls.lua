local null_ls = require("null-ls")

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

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
      vim.lsp.buf.formatting(bufnr)
      -- vim.lsp.buf.formatting_sync()
    end, {})

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      -- command = "undojoin | LspFormatting",
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

null_ls.setup({
  sources = {
    -- Diagnotics
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.standardjs.with({
      condition = enable_standardjs,
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = enable_eslint,
    }),
    -- null_ls.builtins.diagnostics.cpplint,

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
    -- null_ls.builtins.formatting.eslint_d.with({
    --   condition = enable_eslint,
    -- }),
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
  on_attach = on_attach,
})
