local root_markers1 = {
  '.emmyrc.json',
  '.emmyrc.lua',
  '.luarc.json',
  '.luarc.jsonc',
}
local root_markers2 = {
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}

---@type vim.lsp.Config
return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2, { '.git' } }
    or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
  workspace_required = false,
  settings = {
    emmylua = {
      -- Tell the server which Lua you're using (usually LuaJIT, for Neovim).
      codeLens = { enable = true },
      hint = { enable = true },
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      -- Make the server aware of Neovim runtime files.
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
