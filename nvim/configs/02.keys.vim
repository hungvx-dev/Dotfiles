let mapleader=" "

" mapc <c-p> 
" unmap <C-p>
" nnoremap <c-p> <nop>

" Use black hole for delete. Don't want to store in register with dd.
" For cut, use visual and x instead
" nnoremap d "_d
" vnoremap d "_d

"------- Hack paste
" xnoremap p "0p
" nnoremap p "0p

" also for yank
" replace currently selected text with default register without yanking it
vnoremap p "_dP

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <leader>q :q<CR>
" nnoremap <C-q> :q<CR>


" also for yank
" replace currently selected text with default register without yanking it
" vnoremap p "_dP
" vnoremap P "_dP

" Move
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
" nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
" nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

nnoremap H ^
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


" noremap ; :
" inoremap jj <Esc>
nnoremap <silent> <leader><CR> :noh<CR>

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" BUFFER MOTIONS {{{
nnoremap gt :bnext <CR>
nnoremap gT :bprevious <CR>
" map <A-tab> :bd<CR> "Delete buffer file
" nnoremap <tab> :bn<CR>
"
" nnoremap <S-tab> :bp<CR>
" }}}

"------- MORE CUSTOMIZE
" nnoremap <tab> :tabnext<CR>
" nnoremap <S-tab> :tabprevious<CR>
" }}

" Disable Ctrl-Z
nnoremap <c-z> <NOP>

" Disable ex mode
nnoremap Q <Nop>

nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <leader>f :PrettierAsync<CR>
nnoremap <leader>i :EslintFixAll<CR>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>

" TELEScope {{{
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>j <cmd>Telescope grep_string<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader><leader> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

