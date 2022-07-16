" PYTHON PROVIDERS {{{
if has('macunix')
  " OSX
  let g:python_host_prog = '/usr/local/bin/python2' " ---- Set python 2 provider
  let g:python3_host_prog = '/usr/local/bin/python3' " --- Set python 3 provider
elseif has('unix')
  " Ubuntu
  let g:python3_host_prog = '/usr/bin/python3' " --------- Set python 3 provider
  let g:python_host_prog = '/usr/bin/python' " ----------- Set python 2 provider
elseif has('win32') || has('win64')
  " Window
endif
" }}}

" GENERAL CONFIG
set completeopt=longest,menu,noselect
" COLOR SOLARIZE {{
set termguicolors " -------------------------------------- True color for neovim

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif
set t_Co=256
colorscheme dracula
highlight NonText guifg=#4A4A59
highlight Comment cterm=italic gui=italic
highlight SpecialKey guifg=#4A4A59
highlight SignColumn guibg=transparent
highlight! link SignColumn LineNr
" hi cursorlinenr guifg=white guibg=#006969
highlight cursorlinenr guibg=#004748 guifg=#EFFF00
" }}

" SYNTAX {{{
syntax on " --------------------------------------------- Enable Syntax for Code
set syntax=whitespace
syntax enable
" }}}

" DISPLAY {{{
set cc=+1
set encoding=utf8
set fileencoding=utf-8
set termencoding=utf-8 " ------------------------------------------ Always utf-8
set colorcolumn=0 " ------------------------------------------- line column show
set formatoptions=tcqronj " --------------- Stop newline continution of comments
set title " ------------------------------------- Let vim set the terminal title
set showcmd	" --------------- Show command in bottom right portion of the screen
set hidden " ----------------------------- Switch between buffers without saving
set noshowmode " -------------------------- Hide default mode text (e.g. INSERT)
set display+=lastline " -------------------- As must as possible of the lastline
set previewheight=3 " ----------------------------------- Smaller preview height
set clipboard+=unnamedplus
" let g:clipboard = {
"       \   'name': 'myClipboard',
"       \   'copy': {
"         \      '+': ['tmux', 'load-buffer', '-'],
"         \      '*': ['tmux', 'load-buffer', '-'],
"         \    },
"         \   'paste': {
"           \      '+': ['tmux', 'save-buffer', '-'],
"           \      '*': ['tmux', 'save-buffer', '-'],
"           \   },
"           \   'cache_enabled': 1,
"           \ }
set go-=T " ------------------------------------- Hide MacVim toolbar by default
set conceallevel=0
set splitbelow
set nu
set rnu
" }}


" CURSOR {{
set mouse=a
set mousehide " ----------------------------------------- Hide mouse when typing
set cursorline
set ruler " -------------- Display current cursor position in lower right corner
" }}

" TAB STUFF {{
set tabstop=2
set shiftwidth=2
set softtabstop=0
set scrolloff=5
set sidescrolloff=8
set laststatus=2 " ------------------------------------- Always show status line
set showtabline=2 " ---------------------------------------- Always show tabline
set linespace=3 " ------------------------- Prefer a slightly higher line height
set shiftround
set cindent
set expandtab
set si "smart indent
set smarttab
set autoindent
set backspace=indent,eol,start
" }}

set list
set listchars =tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,space:⋅,eol:↴

set wrap
set textwidth=80

" Case insensitive searching UNLESS /C or capital in search
set incsearch
set hlsearch
set ignorecase
set wildmenu
set smartcase

set shortmess+=c
set signcolumn=yes " --------------------------------- Always open gutter column
set cmdheight=1
set pumheight=15 " --------------------------------- limit autocomple candidates
set updatetime=250 "____________ smaller updatetime for CursorHold & Cursor Hold
set ttimeoutlen=50
set timeoutlen=450

" Folding {{
set foldenable
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=0
set foldlevelstart=90
augroup folding_vim
  autocmd!
  autocmd FileType vim        setlocal foldmethod=marker
  autocmd FileType snippets   setlocal foldmethod=marker
augroup END
" }}

" Undo {{
set undolevels=100 " ------------------------------ Default is 1000 -> Too large
set undoreload=1000 " ---------------------------- Default is 10000 -> Too large
set undodir=~/.config/nvim/undodir " -------------- Default folder for undo step
" }}

" INTERFACE {{{
set guioptions-=m " ------------------------------------------- Remove menu bar
set guioptions-=T " -------------------------------------------- Remove toolbar
set guioptions-=r " ------------------------------ Remove right-hand scroll bar
set guioptions-=L " ------------------------------- Remove left-hand scroll bar


" File
filetype plugin on
filetype indent on
set autoread "________________________________________ Auto reloaded Edited File
set autowrite "______________Write the old file out when switching between files
set noswapfile "________________________________________-- Dont create wrap file
set nobackup "_____________________________________________---- Dont save backup
set nowb
set noswapfile
set sessionoptions+=globals
let g:jsx_ext_required = 1 " ------------------------ Dont detect js file as jsx

if isdirectory($HOME . '/.vim/_backup') == 0
  :silent !mkdir -p ~/.vim/_backup >/dev/null 2>&1
endif
set backupdir=~/.vim/_backup/
set backup
set backupcopy=yes
set backupskip=~/.vim/_backup/

if isdirectory($HOME . '/.vim/_temp') == 0
  :silent !mkdir -p ~/.vim/_temp >/dev/null 2>&1
endif
set directory=~/.vim/_temp//

if isdirectory($HOME . '/.vim/_viminfo') == 0
  :silent !mkdir -p ~/.vim/_viminfo >/dev/null 2>&1
endif

set listchars=tab:\·\·,trail:\-,precedes:←,extends:→


" Spell"
set spell " ------------------------------------------- Enable spelling checking
set spelllang=en,cjk " ----------------------------------------- Default language
set spelloptions=camel " -------------------------------------- Support JS camel
set spellsuggest=best,9
set complete+=spell
" set spellfile=$HOME/Dev/VimSpell/en.fut-8.add
hi SpellBad cterm=underline "ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline "ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline "ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline "ctermfg=203 guifg=#ff5f5f
nnoremap <silent> <F5> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
nnoremap <leader>Fs :normal! mz[s1z=`z<CR> " ------------- Autocomplete fix spell
fun! IgnoreCamelCaseSpell()
    syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
autocmd BufRead,BufNewFile * :syntax on

highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
highlight IndentBlanklineIndent6 guifg=#304866 gui=nocombine

let g:gitblame_date_format = '%r,%x,%X'
let g:gitblame_message_template = '<author> | <date> | <summary>'

let g:gitgutter_enabled = 1
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
hi rainbowcol1 guifg=#ff00004d

highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
" augroup qs_colors
"   autocmd!
"   autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
"   autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
" augroup END

set scroll=10

