" hungvx.dev SuperVIM
lua pcall(require, 'impatient')

runtime configs/01.settings.vim
runtime configs/02.key-maps.vim
runtime configs/03.autocmds.vim
runtime configs/04.highlight.vim
runtime configs/05.functions.vim

lua require('internal.packer_commands')
lua require('utils.globals')
lua require('config')
lua require('colorscheme')
lua require('autocmds')
lua require('functions')
" lua require('internal.cursorword')


lua require('lsp.config')
lua require('lsp.setup')
lua require('lsp.functions')

