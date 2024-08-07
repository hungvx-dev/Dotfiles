nnoremap <expr> n  'Nn'[v:searchforward]
vnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
vnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]
"cnoremap <c-n> <down>
"cnoremap <c-p> <up>

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
" inoremap jj <esc>
nnoremap <silent> <leader><CR> :noh<CR>

" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
nnoremap <M-k> :m .-2<CR>==
nnoremap <M-j> :m .+1<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" nnoremap <C-d> 10j
" nnoremap <C-u> 10k
" vnoremap <C-d> 10j
" vnoremap <C-u> 10k

" BUFFER MOTIONS {{{
nnoremap gt :bnext <CR>
nnoremap gT :bprevious <CR>
" nnoremap <tab> :tabnext<CR>
" nnoremap <S-tab> :tabprevious<CR>
" }}
nnoremap <silent> <F5> :set spell!<cr>

" Disable Ctrl-Z
nnoremap <c-z> <NOP>
" Disable ex mode
nnoremap Q <Nop>

vnoremap < <gv
vnoremap > >gv

nnoremap ; <Plug>(clever-f-repeat-forward)

" nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" nnoremap <M-n> <cmd>lua require"illuminate".next_reference{wrap=true}<cr>
" nnoremap <M-p> <cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
" nnoremap gr <cmd>TroubleToggle lsp_references<cr>


" TELEScope {{{ ================================================================
" nnoremap <leader>fp <cmd>lua require('plugins.telescope').project_files()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })<cr>
" nnoremap <leader>fs <cmd>lua require('plugins.telescope.pickers.multi-rg')()<cr>
nnoremap <leader>fp <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fi <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>


nnoremap <leader>q <cmd>lua require('utils').toggle_quicklist()<cr>
