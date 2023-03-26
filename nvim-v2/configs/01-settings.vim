let mapleader=" "
let speeddating_no_mappings=1
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" System {{{ ===================================================================
set mouse=a
set clipboard+=unnamed,unnamedplus
set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=10
set updatetime=100
" }}}


" Backup files {{{ =============================================================
if !isdirectory($HOME.'/.config/nvim/files') && exists('*mkdir')

  call mkdir($HOME.'/.config/nvim/files')

endif
set backup
set backupdir   =$HOME/.config/nvim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.config/nvim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.config/nvim/files/undo/
set viminfo     ='1000,n$HOME/.config/nvim/files/info/viminfo
" Spell"
set nospell " ------------------------------------------- Enable spelling checking
set spelllang=en_us " ----------------------------------------- Default language
set spelloptions=camel " -------------------------------------- Support JS camel
set spellsuggest=best,9
set complete+=kspell
set spellfile=$HOME/.config/nvim/files/spell/en.fut-8.add
" }}}


" SYNTAX {{{ ===================================================================
syntax on "  Enable Syntax for Code
syntax enable
filetype plugin on
filetype indent on
" set syntax=whitespace
" }}}


" Theme {{{ ====================================================================
set termguicolors
" colorscheme tokyonight
" }}}


" Display {{{ ==================================================================
set encoding=utf8
set fileencoding=utf-8
set termencoding=utf-8
set number
set relativenumber
set splitright
set splitbelow
set signcolumn=yes
set cmdheight=1
set pumheight=15 " --------------------------------- limit autocomple candidates
set hidden
set noshowmode
set noemoji
" set laststatus=2
set scrolloff=8
set noswapfile
" set scroll=10
set display+=lastline
set ruler
set cursorline
" }}}


" Autocompletion {{{ ===========================================================
set complete-=i " ------------------------------ disable scanning included files
set complete-=t " --------------------------------------- disable searching tags
set completeopt=menu,menuone,noselect
" set completeopt=longest,menu,noselect
" }}}


" Disable bell
set noerrorbells
set novisualbell
set t_vb=
" }}}


" Folding {{{ ==================================================================
" set foldenable
" set foldmethod=marker
" set foldcolumn=0
" set foldnestmax=0
" set foldlevel=99
" set foldlevelstart=99
" }}}


" Tab and indent {{{ ===========================================================
set tabstop=2
set softtabstop=2
set showtabline=2 " ---------------------------------------- Always show tabline
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set autoindent
set smartindent
set cindent
set backspace=indent,eol,start
" }}}


" Search {{{ ==================================================================
set incsearch
set hlsearch
set ignorecase
set wildignore="*node_modules/**"
set smartcase
" }}}

" Other {{{ ===================================================================
set lazyredraw
set shortmess+=c
set formatoptions-=cro
set conceallevel=0
" set virtualedit=all
set list
set listchars =tab:»\ ,extends:→,precedes:←,nbsp:·,trail:·,eol:↴
" set statusline=\ 
set fillchars=stl:\ 
set fillchars+=stlnc:\ 
" set fillchars+=vert:\|
set fillchars+=eob:\ 
set fillchars+=fold:\ 
set fillchars+=foldsep:\│
set fillchars+=foldopen:
set fillchars+=foldclose:❯
" }}}
"
