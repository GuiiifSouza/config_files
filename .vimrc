set nocompatible

" ================ General Config ====================

set nonumber                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=                     "Allow use mouse to move vim cursor
set hidden                      "Open a new buffer without save current
set laststatus=2
set confirm
set splitright
set splitbelow

syntax on                       "Highlight syntax
let mapleader=','               "Use ',' as <leader>


" Highlight line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

" True colors
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
  set termguicolors
endif

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

autocmd Filetype javascript setlocal ts=2 sw=2
autocmd Filetype vue setlocal ts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sw=2
autocmd Filetype blade setlocal ts=2 sw=2

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Security ==============================

set modelines=0
set nomodeline

" ================ Plugins  ========================

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'craigemery/vim-autotag'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'jwalton512/vim-blade'
Plug 'terroo/vim-auto-markdown'
Plug 'jvanja/vim-bootstrap4-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kylelaker/riscv.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'scrooloose/nerdcommenter' "commenter <++>
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kaicataldo/material.vim', { 'branch': 'main' } "'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
Plug 'othree/html5.vim'
Plug 'APZelos/blamer.nvim'

call plug#end()

" ================ Plugins configuration  ========================

let g:material_theme_style = 'darker-community'
let g:material_terminal_italics = 1
colorscheme material

" git lents da deep web
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_prefix = ' > '
let g:blamer_template = '<committer> <summary> <committer-time>'
let g:blamer_date_format = '%d/%m/%y'
highlight Blamer guifg=lightgrey

" Configuração do CoC
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-vetur',
      \ 'coc-phpls',
      \]

let g:coc_tsserver_opts = {
      \ 'preferences': {
      \   'importModuleSpecifier': 'relative'
      \ }
      \}

" Mapeamento de tecla para abrir a lista de erros
nmap <leader>e <Plug>(coc-diagnostic-next)

" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Fuzzy configuration
let g:fzf_preview_window = []

let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout reverse --margin=0,0 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

nnoremap <C-f> :Ag<Space><CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ================ Functions ===============
" ================ Keybindind and shortcuts ===============

if $XDG_SESSION_TYPE == 'x11'
    " Copy to clipboard x11
    vmap x "+c
    vmap <C-c> "+y
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <ESC>"+pa
else
    " Copy to clipboard wayland
    nnoremap <C-@> :call system("wl-copy", @")<CR>
    xnoremap "+y y:call system("wl-copy", @")<cr>
    nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
    nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
    xnoremap <C-c> y:call system("wl-copy", @")<cr>
    nnoremap <C-v> :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
endif

map <C-s> :w<CR>
map <C-z> :u<CR>
map <C-q> :q<CR>

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <c-p> :Files<cr>
nnoremap <s-m-p> :GFiles<cr>
nnoremap <silent> <S-Tab> :call <SID>show_documentation()<CR>
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
nmap ++ <plug>NERDCommenterToggle
vmap ++ <plug>NERDCommenterToggle
