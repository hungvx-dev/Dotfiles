" hungvx.dev SuperVIM

" CONFIG'S SOURCES {{{
runtime configs/01.setting.vim " --------------------------------------- Configs
" runtime configs/init.vim "-------------------------------------- Pluggins list
runtime configs/03.functions.vim " ----------------------------------- Functions
runtime configs/02.keys.vim " ------------------------------------------ Keymaps
" runtime configs/04.neovide.vim
lua require('init')
set scroll=10
