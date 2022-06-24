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
set updatetime=300          " Update time for diagnostic hover
set incsearch hlsearch      " highlight search while typing it out
set autoindent smartindent  " smart indent
set ignorecase smartcase    " ignore case unless you type uppercase
set number relativenumber   " enable relative line numbering
set scrolloff=8 siso=5      " offsets for scrolling
set pastetoggle=<F10>       " paste mode to allow for pasting multiline stuff without messing it up
set shortmess+=Ic           " dont show info or warnings when using completion and disable intro
set formatoptions-=o        " change auto formating of comments (doesn't work always due to filetype after-plugins)
set signcolumn=number       " show sign column in number column
set inccommand=split        " show live effects of substitute(neovim only)
set selection=exclusive     " better behaviour for visual mode selection
set virtualedit=onemore     " allow moving cursor past last character
set clipboard=unnamedplus   " use system clipboard when yanking and deleting (v slow)
set mouse=a                 " enable mouse usage
set undofile                " turn on persistent-undo
set undodir=$XDG_DATA_HOME/nvim/undo//      " directory where the undo files will be stored
set completeopt=menuone,noinsert,noselect   " completion menu options

set backupcopy=yes          " use modelines instead (https://nichir.in/posts/vim-cant-edit-files/)
set hidden

let mapleader=" "
let g:python3_host_prog="$XDG_DATA_HOME/nvim/venv/bin/python3"


" ---------------------------------------------------------------------------------------------------------------------
"                                   Plugins
" ---------------------------------------------------------------------------------------------------------------------


call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

" theme
let g:edge_diagnostic_line_highlight = 1
let g:edge_better_performance = 1
Plug 'sainnhe/edge'", {'commit': 'e3b9bc1'}  " guy changed colors after this wtf
Plug 'datwaft/bubbly.nvim'

" QOL
Plug 'talek/obvious-resize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tommcdo/vim-lion'
Plug 'lukas-reineke/indent-blankline.nvim'
set colorcolumn=500 " https://github.com/lukas-reineke/indent-blankline.nvim/issues/59#issuecomment-806374954

" file operations
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'

" git
Plug 'tpope/vim-fugitive'

" IDE stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()     " does `filetype plugin indent on` and `syntax enable`

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.7, 'highlight': 'VertSplit' } }
let g:fzf_action = {
\   'ctrl-s': 'split',
\   'ctrl-v': 'vsplit',
\ }

" indentline setup
let g:indent_blankline_char_list = ['▎', '▏']
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_show_trailing_blankline_indent = v:false


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

" actually go to the end
nnoremap 0 g0
nnoremap <HOME> g<HOME>
nnoremap <S-HOME> <HOME>
nnoremap $ g$
nnoremap <END> g<END>
nnoremap <S-END> <END>

vnoremap > >gv
vnoremap < <gv

nnoremap <silent> <C-l> :noh<CR>
nnoremap G Gzz
noremap N Nzz
noremap n nzz

" file navigation
nnoremap \ <C-^>
nmap <silent> \| :20Lexplore<CR>


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

" move between splits and tmux panes with the same keys
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>

" resize splits
nnoremap <silent> <M-k> :ObviousResizeUp 2<CR>
nnoremap <silent> <M-j> :ObviousResizeDown 2<CR>
nnoremap <silent> <M-h> :ObviousResizeLeft 2<CR>
nnoremap <silent> <M-l> :ObviousResizeRight 2<CR>

" replace without yanking selected text
vnoremap p "_dP

" fzf
nnoremap <silent> <leader>ff :FZF<CR>
nnoremap <silent> <leader>fh :FZF ~<CR>
nnoremap <silent> <leader>fl :BLines<CR>

" open terminal in a split
nmap <silent> <leader>ts :botright 9split term://bash<CR>
nmap <silent> <leader>tv :botright 60vsplit term://bash<CR>

" use tab for completion
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" open and reload vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>:noh<CR>

" find symbol group info under the cursor
nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\   . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\   . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" ---------------------------------------------------------------------------------------------------------------------
"                                  Theming
" ---------------------------------------------------------------------------------------------------------------------


set termguicolors
set background=dark
colorscheme edge

" hi Normal guibg=#24262e
hi Normal guibg=#1c1e24
hi String guifg=#5b626f
hi EndOfBuffer guifg=#1c1e24 guibg=#1c1e24
" hi StatusLine guifg=#bbc2cf guibg=#1c1e24
" hi MatchParen guifg=#111111 guibg=#b1b1b1

" cursor style
set guicursor=n-c-i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20

set fillchars=eob:\ ,diff:\ 


" ---------------------------------------------------------------------------------------------------------------------
"                                  Miscellaneous
" ---------------------------------------------------------------------------------------------------------------------


" use gx to open files using wslview
let g:netrw_browsex_viewer="wslview"
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


" ---------------------------------------------------------------------------------------------------------------------
"                                  LSP Configuration
" ---------------------------------------------------------------------------------------------------------------------


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr>
    \ pumvisible() ? coc#_select_confirm() :
    \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <silent> gd         <Plug>(coc-definition)
nmap <silent> gr         <Plug>(coc-references)
nmap <silent> <leader>[  <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>]  <Plug>(coc-diagnostic-next)
nmap <silent> <leader>e  <plug>(coc-diagnostic-info)
nmap <silent> <leader>c  <plug>(coc-codeaction-line)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>f  <Plug>(coc-format-selected)
xmap <silent> <leader>f  <Plug>(coc-format-selected)

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = ['coc-pyright', 'coc-go', 'coc-json']

lua << EOF
vim.g.bubbly_statusline = {
    'paste',
    'mode',
    'path',
    'branch',
    'truncate',
    'coc',
    'divisor',
    'filetype',
    'progress',
}
vim.g.bubbly_palette = {
  background = "Normal",
  foreground = "Black",
  black = "#000000",
  red = "#f94144",
  orange = "#FF5555", --"#e36414",
  green = "#90be6d",
  lightgreen = '#ecf39e',
  yellow = "#f9dc5c",
  blue = "#2196f3",
  purple = "#1E3163", --"#003f88",
  cyan = "#43aa8b",
  white = "#ffffff",
  lightgrey = "#adb5bd",
  darkgrey = "#7f8490",
}
vim.g.bubbly_colors = {
    paste = 'purple',
    mode = {
        normal = { background = 'orange', foreground = 'white' },
        insert = { background = 'blue', foreground = 'white' },
        visual = { background = 'green', foreground = 'white' },
        visualblock = { background = 'lightgreen', foreground = 'black' },
        command = { background = 'purple', foreground = 'white' },
        terminal = { background = 'darkgrey', foreground = 'black' },
        replace = { background = 'red', foreground = 'black' },
        default = 'white'
    },
    path = { path = { background = 'purple', foreground = 'white' } },
    branch = { background = 'darkgrey', foreground = 'black' },
    filetype = { background = 'purple', foreground = 'white' },
    coc = {
        error = 'red',
        warning = 'orange',
    },
    progress = {
        rowandcol = { background = 'darkgrey', foreground = 'black' },
        percentage = { background = 'lightgrey', foreground = 'black' },
    },
}
vim.g.bubbly_inactive_color = { background = 'black', foreground = 'lightgrey' }
EOF
