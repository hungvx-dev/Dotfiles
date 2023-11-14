" autocmd InsertLeave,WinEnter * set cursorline
" autocmd InsertEnter,WinLeave * set nocursorline

" autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE
augroup qs_colors
  autocmd!
  autocmd ColorScheme * hi QuickScopePrimary ctermfg=155 guibg='#4A4A59'
  " autocmd ColorScheme * hi QuickScopeSecondary ctermfg=81 guibg='#4A4A59'
augroup END

" Spell
" augroup spelunker
"   autocmd!
"   " Setting for g:spelunker_check_type = 1:
"   " autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md call spelunker#check()
"
"   " Setting for g:spelunker_check_type = 2:
"   autocmd CursorHold *.vim,*.js,*.jsx,*.md,*.ts,*.tsx,*.vue call spelunker#check_displayed_words()
" augroup END

" fun! IgnoreCamelCaseSpell()
"     syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
" endfun
"
" autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
" hung hung hung
