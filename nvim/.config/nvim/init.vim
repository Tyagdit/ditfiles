" NeoVim 0.7.2


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
set laststatus=3            " Enable global statusline
set mouse=a                 " enable mouse usage
set undofile                " turn on persistent-undo
set undodir=$XDG_DATA_HOME/nvim/undo//      " directory where the undo files will be stored
set completeopt=menuone,preview,noinsert,noselect   " completion menu options

set backupcopy=auto         " use modelines instead (https://nichir.in/posts/vim-cant-edit-files/)
set hidden

let mapleader=" "
let g:python3_host_prog="$XDG_DATA_HOME/nvim/venv/bin/python3"


" ---------------------------------------------------------------------------------------------------------------------
"                                   Plugins
" ---------------------------------------------------------------------------------------------------------------------


call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

" theme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'nvim-lualine/lualine.nvim'

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
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9, 'highlight': 'WinSeparator' } }
let g:fzf_preview_window = ['down:60%:border-top', 'ctrl-/']
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

nnoremap G Gzz
noremap N Nzz
noremap n nzz

" who needs autopair plugins
imap () ()<Left>
cmap () ()<Left>
imap {} {}<Left>
cmap {} {}<Left>
imap [] []<Left>
cmap [] []<Left>
imap <> <><Left>
cmap <> <><Left>

" file navigation
nnoremap \ <C-^>
 nmap <silent> \| -
" nmap <silent> \| :20Lexplore<CR>


" to move lines up and down like in sublime
nnoremap <silent> <C-J> :m .+1<CR>==
nnoremap <silent> <C-K> :m .-2<CR>==
inoremap <silent> <C-J> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-K> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-J> :m '>+1<CR>gv=gv
vnoremap <silent> <C-K> :m '<-2<CR>gv=gv

noremap <S-Up> <C-Y>
noremap <S-Down> <C-E>

" move between splits and tmux panes with the same keys
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>

" resize splits
" nnoremap <silent> <M-k> :ObviousResizeUp 2<CR>
" nnoremap <silent> <M-j> :ObviousResizeDown 2<CR>
" nnoremap <silent> <M-h> :ObviousResizeLeft 2<CR>
" nnoremap <silent> <M-l> :ObviousResizeRight 2<CR>

" replace without yanking selected text
vnoremap p "_dP

" fzf
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fh :Files ~<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fs :Rg<CR>
nnoremap <silent> <leader>fr :History<CR>

" open terminal in a split
nmap <silent> <leader>ts :botright 9split term://bash<CR>
nmap <silent> <leader>tv :botright 60vsplit term://bash<CR>

" open and reload vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>
nnoremap <silent> <leader>r :source $MYVIMRC<CR>:noh<CR>

" find symbol group info under the cursor
nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\   . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\   . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" ---------------------------------------------------------------------------------------------------------------------
"                                  Theming
" ---------------------------------------------------------------------------------------------------------------------


set termguicolors
set background=dark
let g:catppuccin_flavour = "mocha"

" cursor style
" set guicursor=n-c-i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20

" remove tildes at end of buffer and hyphens in diff view (note the space at the end)
set fillchars=eob:\ ,diff:╱


" ---------------------------------------------------------------------------------------------------------------------
"                                  Miscellaneous
" ---------------------------------------------------------------------------------------------------------------------


" use gx to open files using wslview
let g:netrw_browsex_viewer="wslview"
" file browser options
let g:netrw_liststyle=3         " tree style listing
let g:netrw_altfile=1           " dont count netrw buffer for altfile switching
" cant change the tree character
" hi netrwTreeBar guibg=#555555 guifg=#555555

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


function! s:float_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover', 'float')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! s:preview_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover', 'preview')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent> <S-k> :call <SID>float_documentation()<CR>
nnoremap <silent> <M-k> :call <SID>preview_documentation()<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ coc#jumpable() ? coc#snippet#next() :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <silent><expr> <S-TAB>
    \ coc#pum#visible() ? coc#pum#prev(1) :
    \ coc#jumpable() ? coc#snippet#prev() :
    \ "\<C-h>"
inoremap <silent><expr> <CR>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#pum#visible() ? coc#pum#confirm() :
    \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" scroll floats/popups in insert mode
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>e  <Plug>(coc-diagnostic-info)
nmap <silent> <leader>c  <Plug>(coc-codeaction-line)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>rf <Plug>(coc-refactor)
" use gq with the formatwexpr autocmd up ahead
" nmap <silent> <leader>f  <Plug>(coc-format-selected)
" xmap <silent> <leader>f  <Plug>(coc-format-selected)

nnoremap <silent> _  :call <SID>toggle_outline()<CR>
function! s:toggle_outline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

augroup CocAuGroup
  autocmd!
  autocmd FileType go,python,lua,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = ['coc-pyright', 'coc-go', 'coc-json', 'coc-sumneko-lua']


" ---------------------------------------------------------------------------------------------------------------------
"                                  Lua Heredoc
" ---------------------------------------------------------------------------------------------------------------------


lua << EOF
---- Theme config
local cp_palette = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
    dim_inactive = { enabled = true, percentage = 0.01 },
    integrations = { coc_nvim = true },
    custom_highlights = {
      WinSeparator = { fg = cp_palette.blue },
      CocFloating = { bg = cp_palette.base },
      CocInlayHint = { fg = cp_palette.surface2, style = { 'bold', 'italic' } },
    },
})
vim.cmd [[colorscheme catppuccin]]


---- Statusline config

-- Alter theme to change color of the middle portion (lualine_c) to corresponding mode color
-- reference: https://github.com/catppuccin/nvim/blob/main/lua/lualine/themes/catppuccin.lua
local custom_cp = require('lualine.themes.catppuccin')
-- match leftmost portion to middle portion in normal mode
custom_cp.normal.a  = { bg = custom_cp.normal.c.bg,  fg = custom_cp.normal.c.fg,  gui = 'bold' }
-- match middle portion to leftmost portion for rest of the modes
custom_cp.insert.c = { bg = custom_cp.insert.a.bg, fg = custom_cp.insert.a.fg }
custom_cp.command.c = { bg = custom_cp.command.a.bg, fg = custom_cp.command.a.fg }
custom_cp.visual.c = { bg = custom_cp.visual.a.bg, fg = custom_cp.visual.a.fg }
custom_cp.replace.c = { bg = custom_cp.replace.a.bg, fg = custom_cp.replace.a.fg }
-- change rightmost portion colors
custom_cp.normal.z = custom_cp.normal.a
custom_cp.insert.z = custom_cp.normal.a
custom_cp.command.z = custom_cp.normal.a
custom_cp.visual.z = custom_cp.normal.a
custom_cp.replace.z = custom_cp.normal.a
-- change middle and rightmost portions bg to match terminal bg in normal mode
-- custom_cp.normal.c = { bg = cp_palette.base }
-- custom_cp.normal.z = { bg = cp_palette.base }

require('lualine').setup {
    options = {
        theme = custom_cp,
        icons_enabled = false,
        component_separators = '┃',
        section_separators = '',
        refresh = { statusline = 50 }
    },
    sections = {
        lualine_a = {},
        lualine_b = {
            'branch',
            {
                'filename',
                path = 1,  -- relative path
                symbols = { modified = ' +', readonly = ' RO', unnamed = '' }
            },
            {
                'diagnostics',
                color = { bg = cp_palette.mantle }  -- matches normal mode lualine_c bg
            },
        },
        lualine_c = {'mode', 'diff'},  -- changes color according to mode
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'filetype', 'location', 'progress'},
    },
}
EOF
