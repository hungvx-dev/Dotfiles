if has("gui_running")
  if has("gui_gtk2") || has("gui_gtk3")
    set guifont=Fira\ Code\ 11
  elseif has("gui_macvim")
    set guifont=Fira\ Code:h11
  elseif has("gui_win32")
    set guifont=Fira\ Code:h11:cANSI
  endif
endif

set guifont=Fira\ Code:h11
let g:neovide_refresh_rate=120
" let g:neovide_transparency=0.4
" let g:neovide_floating_blur = 0.1
" let g:neovide_floating_opacity = 0.6
let g:neovide_input_use_logo=v:true
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_vfx_mode = "pixiedust"
let g:neovide_cursor_antialiasing=v:true
