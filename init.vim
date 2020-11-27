
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

" NERCommenter
Plug 'preservim/nerdcommenter'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map ; :Files<CR>

" Gitgutter
Plug 'airblade/vim-gitgutter'

" Fugitive
Plug 'tpope/vim-fugitive'

" Vimshell
Plug 'shougo/neocomplcache'
Plug 'shougo/deol.nvim'
"Plug 'shougo/vimproc', {'do' : 'make'}
"Plug 'shougo/vimshell'

" lightline
"Plug 'itchyny/lightline.vim'
"let g:lightline = {
"      \ 'colorscheme': 'seoul256',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"      \ },
"      \ 'component_function': {
"      \   'gitbranch': 'FugitiveHead'
"      \ }
"      \ }

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts'

" COC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
source ~/.config/nvim/coc_config.vim

" SimpylFold Python code folder
Plug 'tmhedberg/SimpylFold'

" nvim-gdb
Plug 'sakhnik/nvim-gdb', { 'do': ':!./test/prerequisites.sh && ./install.sh' }

" Tig
Plug 'iberianpig/tig-explorer.vim'

" hexmode
Plug 'fidian/hexmode'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""

" CONFIGS """""""""""""""""""""""""""""""""""

" NERDTree config
let g:NERDTreeWinPos = "right"

" Vimshell config
"

" Hexmode config
"

" Airline config
" (https://vi.stackexchange.com/questions/3359/how-do-i-fix-the-status-bar-symbols-in-the-airline-plugin)
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" airline theme
let g:airline_theme = 'deus'


"""""""""""""""""""""""""""""""""""""""""""""

