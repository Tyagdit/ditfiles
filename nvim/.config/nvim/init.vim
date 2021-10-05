" NeoVim 0.5.0


" ---------------------------------------------------------------------------------------------------------------------
"                                   General Options
" ---------------------------------------------------------------------------------------------------------------------


set tabstop=4               " rendered spaces per tab
set softtabstop=4           " spaces input when tab key pressed
set shiftwidth=4            " tabs inserted by audoindent
set expandtab               " convert tabs into spaces
set cursorline              " highlight current line
set wildmenu                " graphical menu for commands
set showmatch               " highlight matching (){}[]
set noerrorbells            " no error bells :/
set nowrap                  " dont wrap lines
set splitbelow              " open new split panes to bottom
set splitright              " open new split panes to right
set noshowmode              " don't show mode, the statusline color indicates insert and paste mode
set gdefault                " use the g flag in substitute by default
set autoread                " no message when the current file was changed outside of Vim
set incsearch hlsearch      " highlight search while typing it out
set autoindent smartindent  " smart indent
set ignorecase smartcase    " ignore case unless you type uppercase
set number relativenumber   " enable relative line numbering
set scrolloff=8             " vertical offset for scrolling
set pastetoggle=<F10>       " paste mode to allow for pasting multiline stuff without messing it up
set shortmess+=c            " dont show info or warnings when using completion
set formatoptions-=o        " change auto formating of comments (doesn't work always due to filetype after-plugins)
set signcolumn=number       " show sign column in number column
set inccommand=nosplit      " show live effects of substitute(neovim only)
set selection=exclusive     " better behaviour for visual mode selection
set virtualedit=onemore     " allow moving cursor past last character
set clipboard=unnamedplus   " use system clipboard when yanking and deleting (v slow)
set mouse=a                 " enable mouse usage
set undofile                " turn on persistent-undo
set undodir=$XDG_STATE_HOME/nvim/undo       " directory where the undo files will be stored
set completeopt=menuone,noinsert,noselect   " completion menu options

let mapleader=" "
let g:python3_host_prog="$XDG_DATA_HOME/nvim/venv/bin/python3"


" ---------------------------------------------------------------------------------------------------------------------
"                                   Plugins
" ---------------------------------------------------------------------------------------------------------------------


call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

" theme
let g:edge_diagnostic_line_highlight = 1
let g:edge_better_performance = 1
Plug 'sainnhe/edge', {'commit': 'e3b9bc1'}  " guy changed colors after this wtf
Plug 'datwaft/bubbly.nvim'

" QOL
Plug 'talek/obvious-resize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

" file operations
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'

" git
Plug 'tpope/vim-fugitive'

" IDE stuff
" Plug 'dense-analysis/ale'
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'

call plug#end()     " does `filetype plugin indent on` and `syntax enable`

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.7, 'highlight': 'VertSplit' } }
let g:fzf_action = {
\   'ctrl-s': 'split',
\   'ctrl-v': 'vsplit',
\ }

" " ALE (just for linting)
" let g:ale_linters_explicit=1
" let g:ale_lint_on_text_changed=1
" let g:ale_python_flake8_options = '--ignore=E501,W503'
" let g:ale_linters = {
" \   'python': ['flake8', 'mypy'],
" \   'go': ['gofmt'],
" \ }
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'python': ['black'],
" \   'go': ['gofmt'],
" \ }


" ---------------------------------------------------------------------------------------------------------------------
"                                  Key Bindings
" ---------------------------------------------------------------------------------------------------------------------


" sue me
imap <INSERT> <ESC>`^
vnoremap <INSERT> <ESC>
tnoremap <INSERT> <C-\><C-N>
nnoremap <silent> <ENTER> :w<CR>
nnoremap <silent> <BACKSPACE> :q<CR>
nnoremap <silent> <C-h> :qa<CR>
nnoremap <leader><leader> :

" Unnecessary since wrap is off
" nnoremap j gj
" nnoremap <UP> g<UP>
" nnoremap k gk
" nnoremap <DOWN> g<DOWN>
" nnoremap 0 g0
" nnoremap <HOME> g<HOME>
" nnoremap $ g$
" nnoremap <END> g<END>

" Messes up undo
" inoremap <UP> <CMD>norm gk<CR>
" inoremap <DOWN> <CMD>norm gj<CR>
" inoremap <HOME> <CMD>norm g0<CR>
" inoremap <END> <CMD>norm g$<CR>

vnoremap > >gv
vnoremap < <gv

nnoremap <silent> ? :noh<CR>
nnoremap G Gzz
noremap N Nzz
noremap n nzz

" to move lines up and down like in sublime
nnoremap <silent> <C-J> :m .+1<CR>==
nnoremap <silent> <C-K> :m .-2<CR>==
inoremap <silent> <C-J> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-K> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-J> :m '>+1<CR>gv=gv
vnoremap <silent> <C-K> :m '<-2<CR>gv=gv

" mouse wheel - scroll 6 lines
noremap <ScrollWheelUp>     6<C-Y>
noremap <ScrollWheelDown>   6<C-E>

" move between splits
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>

" resize splits
nnoremap <silent> <M-k> :ObviousResizeUp 2<CR>
nnoremap <silent> <M-j> :ObviousResizeDown 2<CR>
nnoremap <silent> <M-h> :ObviousResizeLeft 2<CR>
nnoremap <silent> <M-l> :ObviousResizeRight 2<CR>

" replace without yanking selected text
vnoremap <leader>p "_dP

" fzf
nnoremap <silent> <leader>ff :FZF<CR>
nnoremap <silent> <leader>fh :FZF ~<CR>
nnoremap <silent> <leader>fl :BLines<CR>

" open terminal in a split
nmap <silent> <leader>ts :botright 9split term://bash<CR>
nmap <silent> <leader>tv :botright 60vsplit term://bash<CR>

" jump to errors
" nmap <silent> <leader>g[ :ALEPreviousWrap<CR>
" nmap <silent> <leader>g] :ALENextWrap<CR>

" use tab for completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" open and reload vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" find symbol group info under the cursor
nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\   . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\   . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" ---------------------------------------------------------------------------------------------------------------------
"                                  Theming
" ---------------------------------------------------------------------------------------------------------------------


set background=dark
colorscheme edge

hi Normal guifg=#bbc2cf guibg=#1c1e24
hi StatusLine guifg=#bbc2cf guibg=#1c1e24
hi MatchParen guifg=#111111 guibg=#b1b1b1
hi String guifg=#5b626f
hi EndOfBuffer guifg=#1c1e24 guibg=#1c1e24

" cursor style
set guicursor=n-c-i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20


" ---------------------------------------------------------------------------------------------------------------------
"                                  Miscellaneous
" ---------------------------------------------------------------------------------------------------------------------


" file browser options
let g:netrw_liststyle=3         " tree style listing
" cant change the tree character
hi netrwTreeBar guibg=#555555 guifg=#555555

" open files in their last used position
autocmd BufReadPost *
\   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\   |   exe "normal! g`\""
\   | endif

" Highlight on yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" format JSON selected in visual mode (default entire file)
com! -range=% FormatJSON <line1>,<line2>!python3 -m json.tool

" WSL yank support (neovim can use a clipboard tool so this is unnecessary)
"" let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
"" augroup WSLYank
""     autocmd!
""     autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif " for WSL1
""     autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif " for WSL2
"" augroup END


" ---------------------------------------------------------------------------------------------------------------------
"                                  LSP Configuration
" ---------------------------------------------------------------------------------------------------------------------


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- attach completion-nvim
    require'completion'.on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'jedi_language_server', 'gopls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end

nvim_lsp.diagnosticls.setup {
    on_attach = om_attach,
    filetypes = { 'python' },
    init_options = {
        linters = {
            flake8 = {
                command = 'flake8',
                debounce = 100,
                args = { '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s', '-' },
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = 'flake8',
                formatLines = 1,
                formatPattern = {
                    '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    W = 'warning',
                    E = 'error',
                    F = 'error',
                    C = 'error',
                    N = 'error'
                }
            },
            mypy = {
                sourceName = 'mypy',
                command = 'mypy',
                args = {
                    '--no-color-output',
                    '--no-error-summary',
                    '--show-column-numbers',
                    '--follow-imports=silent',
                    '%file'
                },
                formatPattern = {
                    '^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$',
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    error = 'error'
                }
            }
        },
        filetypes = {
            python = { 'flake8', 'mypy' }
        }
    },
}

vim.g.bubbly_statusline = {
    'paste',
    'mode',
    'path',
    'branch',
    'truncate',
    'builtinlsp.diagnostic_count',
    'divisor',
    'filetype',
    'progress',
}
vim.g.bubbly_palette = {
  background = "Normal",
  foreground = "Black",
  black = "#000000",
  red = "#f94144",
  orange = '#e36414',
  green = "#90be6d",
  lightgreen = '#ecf39e',
  yellow = "#f9dc5c",
  blue = "#2196f3",
  purple = "#003f88",
  cyan = "#43aa8b",
  white = "#ffffff",
  lightgrey = "#adb5bd",
  darkgrey = "#7f8490",
}
vim.g.bubbly_colors = {
    paste = 'purple',
    mode = {
        normal = { background = 'green', foreground = 'black' },
        insert = { background = 'blue', foreground = 'black' },
        visual = { background = 'lightgreen', foreground = 'black' },
        visualblock = { background = 'lightgreen', foreground = 'black' },
        command = { background = 'purple', foreground = 'white' },
        terminal = { background = 'darkgrey', foreground = 'black' },
        replace = { background = 'red', foreground = 'black' },
        default = 'white'
    },
    path = { path = { background = 'purple', foreground = 'black' } },
    branch = { background = 'darkgrey', foreground = 'black' },
    filetype = { background = 'purple', foreground = 'black' },
    builtinlsp = {
        diagnostic_count = {
            error = 'red',
            warning = 'orange',
        },
    },
    progress = {
        rowandcol = { background = 'darkgrey', foreground = 'black' },
        percentage = { background = 'lightgrey', foreground = 'black' },
    },
}
vim.g.bubbly_inactive_color = { background = 'black', foreground = 'lightgrey' }

EOF
