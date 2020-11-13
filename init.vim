
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=100                  " set a column border for good coding style
set mouse=a                 " set mouse on
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
let g:AutoPairs = {}        " turns off auto closing
set noshowmode              " turns off the bottom line that says --INSERT--
set tabstop=2               " tab spacing
set shiftwidth=2            " tab spacing
set ignorecase
set smartcase

" CODE FOLDING SETTINGS
" Do z + a to codefold functions
" z + M to codefold all
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=0

" LINE BELOW SEARCHES FOR THE CTAGS FILE GOING UP IN DIRECTORIES UNTIL IT FINDS IT
" SO IS THE NEXT LINE FOR CSCOPE
set tags=./tags;,tags;

source ~/.config/nvim/cscope_maps.vim  " cscope 

" FUNCTION BELOW FINDS CSCOPE FILE AUTOMATICALLY
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
    " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()


colorscheme PaperColor

" GET PLUGINS """"""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map ; :Files<CR>

" Gitgutter
Plug 'airblade/vim-gitgutter'

" Fugitive
Plug 'tpope/vim-fugitive'

" lightline
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ }

" COC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
source ~/.config/nvim/coc_config.vim

" SimpylFold Python code folder
Plug 'tmhedberg/SimpylFold'


call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""

" CONFIGS """""""""""""""""""""""""""""""""""


" NERDTree config
let g:NERDTreeWinPos = "right"





"""""""""""""""""""""""""""""""""""""""""""""
