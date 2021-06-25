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
set ignorecase              " Ignore case when searching
set smartcase               " When searching try to be smart about cases 
set cmdheight=1             " cmd line height
set nocscopeverbose 

" CODE FOLDING SETTINGS
" Do z + a to codefold functions
" z + M to codefold all
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=0

" Turn persistent undo on 
" means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" Always show current position
set ruler

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7


" LINE BELOW SEARCHES FOR THE CTAGS FILE GOING UP IN DIRECTORIES UNTIL IT FINDS IT
" SO IS THE NEXT LINE FOR CSCOPE
set tags=./tags;,tags;

"source ~/.config/nvim/cscope_maps.vim  " cscope 

" FUNCTION BELOW FINDS CSCOPE FILE AUTOMATICALLY
"function! LoadCscope()
  "let db = findfile("cscope.out", ".;")
  "if (!empty(db))
    "let path = strpart(db, 0, match(db, "/cscope.out$"))
    "set nocscopeverbose " suppress 'duplicate connection' error
    "exe "cs add " . db . " " . path
    "set cscopeverbose
    "" else add the database pointed to by environment variable
  "elseif $CSCOPE_DB != ""
    "cs add $CSCOPE_DB
  "endif
"endfunction
"au BufEnter /* call LoadCscope()


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
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"source ~/.config/nvim/coc_config.vim

" SimpylFold Python code folder
Plug 'tmhedberg/SimpylFold'

" nvim-gdb
Plug 'sakhnik/nvim-gdb', { 'do': ':!./test/prerequisites.sh && ./install.sh' }

" Tig
Plug 'iberianpig/tig-explorer.vim'

" hexmode
Plug 'fidian/hexmode'

" Tagbar " Depends on ExuberantCtags 5.5 or up
Plug 'preservim/tagbar'

" Grepper
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" HighStr highlighter
Plug 'kdav5758/HighStr.nvim'

" Diffview git differ
Plug 'sindrets/diffview.nvim'

" Which key
Plug 'folke/which-key.nvim'

" Builtin LSP config
Plug 'neovim/nvim-lspconfig'

" nvim-compe autocompleter
Plug 'hrsh7th/nvim-compe'

" vim-glsl for syntax highlighting and indenting
Plug 'tikhomirov/vim-glsl'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""

" CONFIGS """""""""""""""""""""""""""""""""""

" NERDTree config
let g:NERDTreeWinPos = "right"

" Which key config
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" nvim-compe config
lua << EOF
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

-- map tab and s-tab to navigating the comp menu
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" Vimshell config
"

" Hexmode config
"

" Grepper config 
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

" HighStr config
lua << EOF
local high_str = require("high-str")
high_str.setup({
	verbosity = 0,
	highlight_colors = {
		-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
		color_0 = {"#000000", "smart"},	-- Chartreuse yellow
		color_1 = {"#e5c07b", "smart"},	-- Pastel yellow
		color_2 = {"#7FFFD4", "smart"},	-- Aqua menthe
		color_3 = {"#8A2BE2", "smart"},	-- Proton purple
		color_4 = {"#FF4500", "smart"},	-- Orange red
		color_5 = {"#008000", "smart"},	-- Office green
		color_6 = {"#0000FF", "smart"},	-- Just blue
		color_7 = {"#FFC0CB", "smart"},	-- Blush pink
		color_8 = {"#FFF9E3", "smart"},	-- Cosmic latte
		color_9 = {"#7d5c34", "smart"},	-- Fallow brown
	}
})
EOF

" Diffview config
lua << EOF
local cb = require'diffview.config'.diffview_callback
require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = false        -- Requires nvim-web-devicons
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]    = cb("next_entry"),
      ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]      = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]         = cb("select_entry"),
      ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    }
  }
}
EOF

" Key bindings
:nnoremap K :lua print("No LSP Present")<CR> 
:nnoremap L :lua print("No LSP Present")<CR> 
:nnoremap J :lua print("No LSP Present")<CR> 
:nnoremap ' :lua print("No LSP Present")<CR> 
:nnoremap <C-w>v :vnew<CR> 
:nnoremap <C-w><C-v> :vnew<CR> 

" Nvim LSP Config """"""""""""""""""""""""""""""""""

lua << EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.rls.setup{} -- https://github.com/rust-lang/rls#setup
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer

local opts = { noremap=true, silent=true }
vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<Cmd>lua print("No LSP present")<CR>', opts)
vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<Cmd>lua print("No LSP present")<CR>', opts)
vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<cmd>lua print("No LSP present")<CR>', opts)
vim.api.nvim_buf_set_keymap(0, 'n', "'", '<cmd>lua print("No LSP present")<CR>', opts)

local on_attach = function(client, bufnr)
  print("LSP Loaded")
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'L', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'J', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', "'", '<cmd>Tags<CR>', opts)

  -- disable diags showing up
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pylsp", "clangd", "rls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""

