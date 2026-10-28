---@diagnostic disable: unresolved-require, undefined-field

--------------- ICONS
local icons = require('plugins.mini-icons')
package.preload['nvim-web-devicons'] = function()
  require('mini.icons').mock_nvim_web_devicons()
  return package.loaded['nvim-web-devicons']
end
require('mini.icons').setup(icons.opts)

--------------- TREESITTER
local treesitter = require('plugins.treesitter')
local textobjects = require('plugins.treesitter-textobjects')
require('tree-sitter-manager').setup(treesitter.opts)
require('nvim-treesitter-textobjects').setup(textobjects.opts)
local select = require('nvim-treesitter-textobjects.select')
local function mapxo(lhs, query)
  vim.keymap.set({ 'x', 'o' }, lhs, function() select.select_textobject(query, 'textobjects') end)
end
mapxo('af', '@function.outer')
mapxo('if', '@function.inner')
mapxo('ac', '@class.outer')
mapxo('ic', '@class.inner')
mapxo('aa', '@parameter.outer')
mapxo('ia', '@parameter.inner')
mapxo('ai', '@conditional.outer')
mapxo('ii', '@conditional.inner')
mapxo('al', '@loop.outer')
mapxo('il', '@loop.inner')
mapxo('as', '@statement.outer')

---------------EYELINER
local eyeliner = require('plugins.eyeliner')
require('eyeliner').setup(eyeliner.opts)

local neotree = require('plugins.neotree')
local window_picker = require('plugins.window-picker')
if type(neotree.init) == 'function' then neotree.init() end
require('neo-tree').setup(neotree.opts)
require('window-picker').setup(window_picker.opts)
vim.keymap.set('n', '<leader>e', function() require('neo-tree.command').execute({ toggle = true }) end)
vim.keymap.set('n', '<leader>n', function() require('neo-tree.command').execute({ focus = true }) end)

local mason = require('plugins.mason')
require('mason').setup(mason.opts)
local registry = require('mason-registry')
registry.refresh(function()
  for _, name in ipairs(mason.ensure_installed) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok then
      if not pkg:is_installed() then pkg:install() end
    end
  end
end)

local statusline = require('plugins.statusline')
if type(statusline.init) == 'function' then statusline.init() end
vim.cmd('packadd statusline')
require('statusline').setup(statusline.opts)

local statuscol = require('plugins.statuscol')
vim.cmd('packadd statuscol')
require('statuscol').setup(statuscol.opts)

-- FZF
local fzf = require('plugins.fzf')
require('fzf-lua').setup(fzf.opts)
local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, function() vim.cmd(rhs) end, { desc = desc })
end
map('<leader>fb', 'FzfLua buffers sort_mru=true sort_lastused=true', 'Buffers')
map('<leader>fp', 'FzfLua files', 'Find Files')
map('<leader>fo', 'FzfLua oldfiles', 'Recent')
map('<leader>fh', 'FzfLua history', 'History')
map('<leader>fs', 'FzfLua live_grep', 'Grep')
map('<leader>fS', 'FzfLua live_grep resume=true', 'Grep resume')
map('<leader>fi', 'FzfLua grep_curbuf', 'Buffer')
map('<leader>fd', 'FzfLua diagnostics_document', 'Diagnostics')
map('<leader>fk', 'FzfLua keymaps', 'Keymaps')
map('<leader>fH', 'FzfLua highlights', 'Highlights')
map('<leader>fm', 'FzfLua marks', 'Marks')
map('<leader>f:', 'FzfLua command_history', 'Command history')
map('<leader>fgs', 'FzfLua git_status', 'Git status')
map('<leader>fgb', 'FzfLua git_branches', 'Git branches')
map('<leader>fl', 'FzfLua lsp_document_symbols', 'LSP symbols')

local dressing = require('plugins.dressing')
require('dressing').setup(dressing.opts)

local bufferline = require('plugins.bufferline')
vim.o.showtabline = 2
require('bufferline').setup(bufferline.opts)
vim.keymap.set('n', '<leader>bd', bufferline.keys.bufremove, { desc = 'Delete Buffer' })

require('nvim-surround').setup()

local lsp = require('plugins.lsp')
vim.cmd('packadd lsp')
require('lsp').setup(lsp.opts)

local conform = require('plugins.conform')
require('conform').setup(conform.opts)
vim.keymap.set({ 'n', 'v' }, 'gf', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end)

local autotag = require('plugins.autotag')
require('nvim-ts-autotag').setup(autotag.opts)
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   once = true,
--   pattern = { '*.html', '*.tsx', '*.vue' },
--   callback = function()
--     local autotag = require('plugins.autotag')
--     require('nvim-ts-autotag').setup(autotag.opts)
--   end,
-- })

local colorizer = require('plugins.colorizer')
require('colorizer').setup(colorizer.opts)

local comment = require('plugins.comment')
require('mini.comment').setup(comment.mini_comment)
require('ts_context_commentstring').setup(comment.ts_context)
require('todo-comments').setup(comment.todo_comment)
vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })

local git = require('plugins.git')
require('gitsigns').setup(git.opts)

local indent = require('plugins.blink-indent')
require('blink.indent').setup(indent.opts)

local pairs = require('plugins.blink-pairs')
require('blink.pairs').download():pwait(60000)
require('blink.pairs').setup(pairs.opts)

require('colorful-menu').setup()
local cmp = require('plugins.blink-cmp')
local blinkcmp = require('blink.cmp')
blinkcmp.build():pwait()
blinkcmp.setup(cmp.opts)

local lsp_file_ops_loaded = false
vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    local fidget = require('plugins.fidget')
    require('fidget').setup(fidget.opts)

    if lsp_file_ops_loaded then return end
    lsp_file_ops_loaded = true
    local lsp_file = require('plugins.lsp-file')
    require('lsp-file-operations').setup(lsp_file.opts)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    local ok_add = pcall(vim.treesitter.language.add, lang)
    if not ok_add then return end

    pcall(vim.treesitter.start, buf, lang)
  end,
})
