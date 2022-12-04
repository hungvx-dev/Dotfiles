let mapleader=" "

" Yanking
vnoremap p "_dP
vnoremap y myy`y
vnoremap Y myY`y
nnoremap Y y$

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-q> :q<CR>
" nnoremap <C-q> :q<CR>

" Move
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
" nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
" nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" nnoremap H ^
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Resize and split window
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>+ :res +5<CR>
nnoremap <leader>_ :res -5<CR>

nnoremap <leader>% :vsplit<CR>
nnoremap <leader>" :split<CR>

" nnoremap gm m

" noremap ; :
inoremap jj <Esc>
nnoremap <silent> <leader><CR> :noh<CR>

" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" BUFFER MOTIONS {{{
nnoremap gt :bnext <CR>
nnoremap gT :bprevious <CR>
" nnoremap <tab> :tabnext<CR>
" nnoremap <S-tab> :tabprevious<CR>
" }}

" Disable Ctrl-Z
nnoremap <c-z> <NOP>

" Disable ex mode
nnoremap Q <Nop>

vnoremap < <gv
vnoremap > >gv

nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap gf :PrettierAsync<CR>
" nnoremap <leader>i :EslintFixAll<CR>
"
" nnoremap <M-n> <cmd>lua require"illuminate".next_reference{wrap=true}<cr>
" nnoremap <M-p> <cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>

nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>

" TELEScope {{{
nnoremap <leader>fp <cmd>Telescope find_files<cr>
nnoremap <leader>fj <cmd>Telescope grep_string<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fi <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
