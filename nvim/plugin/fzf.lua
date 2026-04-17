if HVIM.plugins.fzf then
  local fzf = require('plugins.fzf')

  vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
  require('fzf-lua').setup(fzf.opts)

  local function map(lhs, rhs, desc)
    vim.keymap.set('n', lhs, function() vim.cmd(rhs) end, { desc = desc })
  end

  -- Files & buffers
  map('<leader>fb', 'FzfLua buffers sort_mru=true sort_lastused=true', 'Buffers')
  map('<leader>fp', 'FzfLua files', 'Find Files')
  map('<leader>fo', 'FzfLua oldfiles', 'Recent')
  map('<leader>fh', 'FzfLua history', 'History')

  -- Search
  map('<leader>fs', 'FzfLua live_grep', 'Grep')
  map('<leader>fS', 'FzfLua live_grep resume=true', 'Grep resume')
  map('<leader>fi', 'FzfLua grep_curbuf', 'Buffer')

  map('<leader>fd', 'FzfLua diagnostics_document', 'Diagnostics')
  map('<leader>fk', 'FzfLua keymaps', 'Keymaps')
  map('<leader>fH', 'FzfLua highlights', 'Highlights')
  map('<leader>fm', 'FzfLua marks', 'Marks')
  map('<leader>f:', 'FzfLua command_history', 'Command history')

  -- Git
  map('<leader>fgs', 'FzfLua git_status', 'Git status')
  map('<leader>fgb', 'FzfLua git_branches', 'Git branches')

  -- LSP
  map('<leader>fl', 'FzfLua lsp_document_symbols', 'LSP symbols')
end
