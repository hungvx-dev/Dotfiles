" autocmd InsertLeave,WinEnter * set cursorline
" autocmd InsertEnter,WinLeave * set nocursorline

" autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE
augroup qs_colors
  autocmd!
  autocmd ColorScheme * hi QuickScopePrimary guifg='#afff5f' ctermfg=155 guibg='#4A4A59'
augroup END
