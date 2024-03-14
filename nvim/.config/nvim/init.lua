-- NeoVim 0.9.0


---------------------------------------------------------------------------------------------------------------------
--                                   General Options
---------------------------------------------------------------------------------------------------------------------


vim.opt.tabstop = 4                 -- rendered spaces per tab
vim.opt.softtabstop = 4             -- spaces input when tab key pressed
vim.opt.shiftwidth = 4              -- tabs inserted by audoindent
vim.opt.expandtab = true            -- convert tabs into spaces
vim.opt.cursorline = true           -- highlight current line
vim.opt.wildmenu = true             -- graphical menu for commands
vim.opt.showmatch = true            -- highlight matching (){}[]
vim.opt.errorbells = false          -- no error bells :/
vim.opt.wrap = false                -- dont wrap lines
vim.opt.splitbelow = true           -- open new split panes to bottom
vim.opt.splitright = true           -- open new split panes to right
vim.opt.showmode = false            -- don't show mode, the statusline color indicates insert and paste mode
vim.opt.gdefault = true             -- use the g flag in substitute by default
vim.opt.autoread = true             -- no message when the current file was changed outside of Vim
vim.opt.updatetime = 300            -- Update time for diagnostic hover
vim.opt.incsearch = true
vim.opt.hlsearch = true             -- highlight search while typing it out
vim.opt.autoindent = true
vim.opt.smartindent = true          -- smart indent
vim.opt.ignorecase = true
vim.opt.smartcase = true            -- ignore case unless you type uppercase
vim.opt.number = true
vim.opt.relativenumber = true       -- enable relative line numbering
vim.opt.scrolloff = 8
vim.opt.siso = 5                    -- offsets for scrolling
vim.opt.pastetoggle = "<F10>"       -- paste mode to allow for pasting multiline stuff without messing it up
vim.opt.shortmess:append("IcS")     -- dont show info or warnings when using completion; disable intro; disable search count
vim.opt.formatoptions:remove("o")   -- change auto formating of comments (doesn't work always due to filetype after-plugins)
vim.opt.signcolumn = "yes"          -- show sign column in number column
vim.opt.inccommand = "split"        -- show live effects of substitute(neovim only)
vim.opt.selection = "exclusive"     -- better behaviour for visual mode selection
vim.opt.virtualedit = "onemore"     -- allow moving cursor past last character
vim.opt.clipboard = "unnamedplus"   -- use system clipboard when yanking and deleting (v slow)
vim.opt.laststatus = 3              -- Enable global statusline
vim.opt.mouse = "a"                 -- enable mouse usage
vim.opt.undofile = true             -- turn on persistent-undo
vim.opt.undodir = vim.fn.expand("$XDG_DATA_HOME/nvim/undo//")      -- directory where the undo files will be stored
vim.opt.completeopt = { "menuone", "preview", "noinsert", "noselect" }   -- completion menu options

vim.opt.backupcopy = "auto"         -- use modelines instead (https://nichir.in/posts/vim-cant-edit-files/)
vim.opt.hidden = true

vim.g.mapleader = " "
vim.g.python3_host_prog = "/usr/bin/python3.10"


---------------------------------------------------------------------------------------------------------------------
--                                 Theming
---------------------------------------------------------------------------------------------------------------------


-- cursor style
-- vim.opt.guicursor = "n-c-i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"

-- remove tildes at end of buffer and hyphens in diff view
vim.opt.fillchars = { eob = " ", diff = "╱" }

vim.opt.termguicolors = true
vim.opt.background = "dark"


---------------------------------------------------------------------------------------------------------------------
--                                 Key Bindings
---------------------------------------------------------------------------------------------------------------------


local keymap = vim.keymap.set
local keymap_opts = {silent = true, noremap = true}

-- sue me
keymap("i", "<INSERT>",         "<ESC>`^",     keymap_opts)
keymap("v", "<INSERT>",         "<ESC>",       keymap_opts)
keymap("t", "<INSERT>",         "<C-\\><C-N>", keymap_opts)
keymap("n", "<ENTER>",          ":w<CR>",      keymap_opts)
keymap("n", "<BACKSPACE>",      ":q<CR>",      keymap_opts)
keymap("n", "<C-h>",            ":qa!<CR>",    keymap_opts)
keymap("n", "<leader><leader>", ":",           keymap_opts)
keymap("i", "<S-Del>",          "<C-o>dw",     keymap_opts)

-- actually go to the end
keymap("n", "0",        "g0",      keymap_opts)
keymap("n", "<HOME>",   "g<HOME>", keymap_opts)
keymap("n", "<S-HOME>", "<HOME>",  keymap_opts)
keymap("n", "$",        "g$",      keymap_opts)
keymap("n", "<END>",    "g<END>",  keymap_opts)
keymap("n", "<S-END>",  "<END>",   keymap_opts)

-- maintain selection when changing indentation in visual mode
keymap("v", ">", ">gv", keymap_opts)
keymap("v", "<", "<gv", keymap_opts)

-- center page when scrolling through searches
keymap("n", "G", "Gzz", keymap_opts)
keymap("n", "N", "Nzz", keymap_opts)
keymap("n", "n", "nzz", keymap_opts)

-- who needs autopair plugins
keymap({ "i", "c" }, "()", "()<Left>", keymap_opts)
keymap({ "i", "c" }, "{}", "{}<Left>", keymap_opts)
keymap({ "i", "c" }, "[]", "[]<Left>", keymap_opts)
keymap({ "i", "c" }, "<>", "<><Left>", keymap_opts)

-- file navigation
keymap("n", "\\", "<C-^>", keymap_opts)
keymap("n", "|", ":NvimTreeToggle<CR>", keymap_opts)
-- keymap("n", "|", ":20Lexplore<CR>", keymap_opts)

-- to move lines up and down like in sublime
keymap("n", "<C-J>", ":m .+1<CR>==",        keymap_opts)
keymap("n", "<C-K>", ":m .-2<CR>==",        keymap_opts)
keymap("i", "<C-J>", "<Esc>:m .+1<CR>==gi", keymap_opts)
keymap("i", "<C-K>", "<Esc>:m .-2<CR>==gi", keymap_opts)
keymap("v", "<C-J>", ":m '>+1<CR>gv=gv",    keymap_opts)
keymap("v", "<C-K>", ":m '<-2<CR>gv=gv",    keymap_opts)

-- move page without moving cursor
keymap("n", "<S-Up>",   "<C-Y>", keymap_opts)
keymap("n", "<S-Down>", "<C-E>", keymap_opts)

-- move between splits and tmux panes with the same keys
vim.g.tmux_navigator_no_mappings = 1
keymap("n", "<M-Left>",  ":TmuxNavigateLeft<cr>",  keymap_opts)
keymap("n", "<M-Down>",  ":TmuxNavigateDown<cr>",  keymap_opts)
keymap("n", "<M-Up>",    ":TmuxNavigateUp<cr>",    keymap_opts)
keymap("n", "<M-Right>", ":TmuxNavigateRight<cr>", keymap_opts)

-- resize splits
-- keymap("n", "<M-k>", ":ObviousResizeUp 2<CR>",    keymap_opts)
-- keymap("n", "<M-j>", ":ObviousResizeDown 2<CR>",  keymap_opts)
-- keymap("n", "<M-h>", ":ObviousResizeLeft 2<CR>",  keymap_opts)
-- keymap("n", "<M-l>", ":ObviousResizeRight 2<CR>", keymap_opts)

-- replace without yanking selected text
keymap("v", "p", "\"_dP", keymap_opts)

-- fzf
keymap("n", "<leader>ff", ":Files<CR>",   keymap_opts)
keymap("n", "<leader>fh", ":Files ~<CR>", keymap_opts)
keymap("n", "<leader>fl", ":BLines<CR>",  keymap_opts)
keymap("n", "<leader>fs", ":Rg<CR>",      keymap_opts)
keymap("n", "<leader>fr", ":History<CR>", keymap_opts)

-- open terminal in a split
keymap("n", "<leader>ts", ":botright 9split term://bash<CR>", keymap_opts)
keymap("n", "<leader>tv", ":botright 60vsplit term://bash<CR>", keymap_opts)

-- open and reload vimrc
keymap("n", "<leader>v", ":edit $MYVIMRC<CR>", keymap_opts)
keymap("n", "<leader>r", ":source $MYVIMRC<CR>:noh<CR>", keymap_opts)

--" find symbol group info under the cursor
-- nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \   . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \   . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


---------------------------------------------------------------------------------------------------------------------
--                                  Miscellaneous
---------------------------------------------------------------------------------------------------------------------


-- -- use gx to open files using wslview
-- vim.g.netrw_browsex_viewer = "wslview"
-- -- file browser options
-- vim.g.netrw_liststyle = 3         -- tree style listing
-- vim.g.netrw_altfile = 1           -- dont count netrw buffer for altfile switching
-- -- cant change the tree character
-- -- hi netrwTreeBar guibg=#555555 guifg=#555555

-- open files in their last used position
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Move cursor to position where it was when the file was last closed",
    pattern = "*",
    callback = function()
      if vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$") and vim.o.ft ~= "commit" then
        vim.cmd([[normal! g`"]])
      end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Briefly highlight yanked text",
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ higroup="IncSearch", timeout=150, on_visual=true })
    end,
})


---------------------------------------------------------------------------------------------------------------------
--                                  Plugins
---------------------------------------------------------------------------------------------------------------------


vim.fn["plug#begin"]("$XDG_CONFIG_HOME/nvim/plugged")
  local Plug = vim.fn["plug#"]

  -- theme
  Plug("catppuccin/nvim", {as = "catppuccin"})
  Plug("nvim-lualine/lualine.nvim")

  -- QOL
  -- Plug("talek/obvious-resize")
  Plug("tpope/vim-commentary")
  Plug("tpope/vim-surround")
  Plug("sheerun/vim-polyglot")
  Plug("christoomey/vim-tmux-navigator")
  Plug("tommcdo/vim-lion")
  Plug("lukas-reineke/indent-blankline.nvim")
  -- Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})

  -- file operations
  Plug("junegunn/fzf.vim")
  -- Plug("tpope/vim-vinegar")  -- netrw is so goddamn buggy
  Plug("nvim-tree/nvim-tree.lua")

  -- git
  Plug("tpope/vim-fugitive")

  -- IDE stuff
  Plug("neoclide/coc.nvim", {branch = "release"})
vim.fn["plug#end"]()     -- does `filetype plugin indent on` and `syntax enable`

-- fzf setup
vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git"
vim.g.fzf_preview_window = { "down:60%:bottom,border", "ctrl-/" }
vim.g.fzf_layout = {
  window = {
    width = 0.8,
    height = 0.9,
    highlight = "WinSeparator",
  }
}
vim.g.fzf_action = {
  ["ctrl-s"] = "split",
  ["ctrl-v"] = "vsplit",
}

-- indent blankline Setup
-- vim.opt.colorcolumn = "500"  -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/59#issuecomment-806374954
require("ibl").setup({
  indent = {
    -- char = { "┆", "┇", },
    -- char = { "▎", "▏", },
    char = { "┃", "│", },
    smart_indent_cap = true,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  exclude = {
    filetypes = { "help" },
    buftypes = { "terminal" },
  }
})

local indent_blankline_hooks = require("ibl.hooks")
indent_blankline_hooks.register(
  indent_blankline_hooks.type.WHITESPACE,
  indent_blankline_hooks.builtin.hide_first_space_indent_level
)

-- nvim-tree Setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function nvim_tree_on_attach(bufnr)
  local nvim_tree = require("nvim-tree.api")

  local function nvim_tree_keymap_opts(desc)
    return { desc = "nvim-tree: "..desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  keymap("n", "-",         nvim_tree.tree.change_root_to_parent,   nvim_tree_keymap_opts("Up"))
  keymap("n", "zz",        nvim_tree.tree.change_root_to_node,     nvim_tree_keymap_opts("CD"))
  keymap("n", "<CR>",      nvim_tree.node.open.edit,               nvim_tree_keymap_opts("Open"))
  keymap("n", "<Right>",   nvim_tree.node.open.edit,               nvim_tree_keymap_opts("Open"))
  keymap("n", "<Left>",    nvim_tree.node.navigate.parent_close,   nvim_tree_keymap_opts("Close Directory"))
  keymap("n", "<S-Right>", nvim_tree.node.navigate.sibling.last,   nvim_tree_keymap_opts("Go To Last Sibling"))
  keymap("n", "<S-Left>",  nvim_tree.node.navigate.sibling.first,  nvim_tree_keymap_opts("Go To First Sibling"))
  keymap("n", "<End>",     "G",                                    nvim_tree_keymap_opts("G"))
  keymap("n", "<Home>",    "gg",                                   nvim_tree_keymap_opts("gg"))
  keymap("n", "<C-l>",     nvim_tree.tree.reload,                  nvim_tree_keymap_opts("Refresh"))
  keymap("n", "i",         nvim_tree.fs.create,                    nvim_tree_keymap_opts("Create"))
  keymap("n", "a",         nvim_tree.fs.create,                    nvim_tree_keymap_opts("Create"))
  keymap("n", "d",         nvim_tree.fs.remove,                    nvim_tree_keymap_opts("Delete"))
  keymap("n", "r",         nvim_tree.fs.rename,                    nvim_tree_keymap_opts("Rename"))
  keymap("n", "x",         nvim_tree.fs.cut,                       nvim_tree_keymap_opts("Cut"))
  keymap("n", "c",         nvim_tree.fs.copy.node,                 nvim_tree_keymap_opts("Copy"))
  keymap("n", "p",         nvim_tree.fs.paste,                     nvim_tree_keymap_opts("Paste"))
  keymap("n", "y",         nvim_tree.fs.copy.filename,             nvim_tree_keymap_opts("Copy Name"))
  keymap("n", "Y",         nvim_tree.fs.copy.relative_path,        nvim_tree_keymap_opts("Copy Relative Path"))
  keymap("n", "<Tab>",     nvim_tree.marks.toggle,                 nvim_tree_keymap_opts("Toggle Bookmark"))
  keymap("n", "m",         nvim_tree.marks.bulk.move,              nvim_tree_keymap_opts("Move Bookmarked"))
  keymap("n", "<Esc>",     nvim_tree.tree.close,                   nvim_tree_keymap_opts("Close"))
  keymap("n", "<BS>",      nvim_tree.tree.close,                   nvim_tree_keymap_opts("Close"))
  keymap("n", "|",         nvim_tree.tree.close,                   nvim_tree_keymap_opts("Close"))
  keymap("n", "<F1>",      nvim_tree.tree.toggle_help,             nvim_tree_keymap_opts("Help"))
  keymap("n", "I",         nvim_tree.tree.toggle_gitignore_filter, nvim_tree_keymap_opts("Toggle Git Ignore"))
  keymap("n", "<S-k>",     nvim_tree.node.show_info_popup,         nvim_tree_keymap_opts("File Info"))
end

local nvim_tree_float_height_ratio = 0.8
local nvim_tree_float_width_ratio = 0.3

require("nvim-tree").setup({
  hijack_netrw = true,
  hijack_cursor = false,
  select_prompts = true,
  on_attach = nvim_tree_on_attach,
  view = {
    centralize_selection = true,
    signcolumn = "yes",
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * nvim_tree_float_width_ratio
        local window_h = screen_h * nvim_tree_float_height_ratio
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
  },
  renderer = {
    add_trailing = true,
    -- indent_width = 4,
    indent_markers = {
      enable = true,
      inline_arrows = false,
      icons = {
        item = "├",
        corner = "╰",
      }
    },
    icons = {
      -- web_devicons = {
      --   file = {
      --     enable = true,
      --   },
      --   folder = {
      --     enable = true,
      --   },
      -- },
      git_placement = "signcolumn",
      diagnostics_placement = "after",
      modified_placement = "before",
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
        modified = true,
      },
      glyphs = {
        modified = "+",
      }
    },
  },
  diagnostics = {
    enable = true,
    show_on_open_dirs = false,
  },
  git = {
    enable = true,
    show_on_open_dirs = false,
  },
  modified = {
    enable = true,
    show_on_open_dirs = false,
  },
})

-- lualine setup
-- Alter theme to change color of the middle portion (lualine_c) to corresponding mode color
-- reference: https://github.com/catppuccin/nvim/blob/main/lua/lualine/themes/catppuccin.lua
local cp_palette = require("catppuccin.palettes").get_palette()
local custom_cp = require("lualine.themes.catppuccin")

local cp_transparent_bg = require("catppuccin").options.transparent_background and "NONE" or cp_palette.mantle
local b = { bg = cp_palette.surface1, fg = cp_palette.text }
local z = { bg = cp_transparent_bg, fg = cp_palette.text, gui = "bold" }

custom_cp.normal = {
  a = { bg = cp_transparent_bg, fg = cp_palette.text, gui = "bold" },
  c = { bg = cp_transparent_bg, fg = cp_palette.text },
}
custom_cp.insert = {
  a = { bg = cp_palette.green, fg = cp_palette.base, gui = "bold" },
  c = { bg = cp_palette.green, fg = cp_palette.base },
}
custom_cp.terminal = {
  a = { bg = cp_palette.green, fg = cp_palette.base, gui = "bold" },
  c = { bg = cp_palette.green, fg = cp_palette.base },
}
custom_cp.command = {
  a = { bg = cp_palette.peach, fg = cp_palette.base, gui = "bold" },
  c = { bg = cp_palette.peach, fg = cp_palette.base },
}
custom_cp.visual = {
  a = { bg = cp_palette.mauve, fg = cp_palette.base, gui = "bold" },
  c = { bg = cp_palette.mauve, fg = cp_palette.base },
}
custom_cp.replace = {
  a = { bg = cp_palette.red, fg = cp_palette.base, gui = "bold" },
  c = { bg = cp_palette.red, fg = cp_palette.base },
}
for k, _ in pairs(custom_cp) do
  custom_cp[k].b = b
  custom_cp[k].z = z
end
-- change middle and rightmost portions bg to match terminal bg
-- custom_cp.normal.c = { bg = cp_palette.base },
-- custom_cp.normal.z = { bg = cp_palette.base, gui = "bold" },

require("lualine").setup {
  options = {
    theme = custom_cp,
    icons_enabled = false,
    globalstatus = true,
    component_separators = "▏",--"┃",
    section_separators = "",
    refresh = { statusline = 50 },
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      "branch",
      {
        "filename",
        path = 1,  -- relative path
        symbols = { modified = " +", readonly = " RO", unnamed = "" }
      },
      {
        "diagnostics",
        color = { bg = cp_palette.mantle },  -- matches normal mode lualine_c bg
      },
      {
        "diff",
        color = { bg = cp_palette.mantle },  -- matches normal mode lualine_c bg
      },
    },
    lualine_c = {"mode"},  -- changes color according to mode
    lualine_x = {},
    lualine_y = {},
    lualine_z = {"filetype", "location", "searchcount"},
  },
}

-- catppuccin setup
-- COMPILE THIS THING AGAIN IF YOU CHANGE IT (:CatppuccinCompile)
-- UNLESS THEY FUCKIN CHANGE THIS COMMAND AS WELL THEN IDK LOOK IT UP
require("catppuccin").setup({
  flavour = "mocha",
  dim_inactive = { enabled = true, percentage = 0.01 },
  integrations = {
    coc_nvim = true,
    nvimtree = true,
    -- treesitter = true,
  },
  highlight_overrides = {
    all = function(colors)
      return {
        WinSeparator = { fg = colors.blue },
        NvimTreeNormal = { bg = colors.base },
        NvimTreeNormalFloat = { bg = colors.base },
        CocFloating = { bg = colors.base },
        CocInlayHint = { fg = colors.surface0, style = { "underline", "italic" } },
      }
    end,
  }
})
vim.cmd("colorscheme catppuccin")

-- treesitter bs
-- require("nvim-treesitter.configs").setup {
--   highlight = {
--     enable = true,
--   },
--   indent = {
--     enable = true,
--   },
--   ensure_installed = {
--     "python",
--     "go",
--     "lua",
--     "json",
--     "hcl",
--     "bash",
--     "comment",
--     "diff",
--     "dockerfile",
--     -- "gitignore",
--     "help",
--     "html",
--     "markdown",
--     "markdown_inline",
--     "nix",
--     "regex",
--     "sql",
--     "vim",
--     "yaml",
--     "toml",
--   },
-- }


---------------------------------------------------------------------------------------------------------------------
--                                 LSP Configuration
---------------------------------------------------------------------------------------------------------------------


vim.g.coc_global_extensions = {"coc-pyright", "coc-go", "coc-json", "coc-yaml", "coc-sumneko-lua", "@yaegassy/coc-ansible"}
vim.g.coc_filetype_map = { ["yaml.ansible"] = "ansible" }

function _G.float_documentation()
  if vim.fn.CocAction("hasProvider", "hover") then
    vim.fn.CocActionAsync("definitionHover", "float")
  else
    vim.fn.feedkeys("K", "in")
  end
end

function _G.preview_documentation()
  if vim.fn.CocAction("hasProvider", "hover") then
    vim.fn.CocActionAsync("definitionHover", "preview")
  else
    vim.fn.feedkeys("K", "in")
  end
end

keymap("n", "<S-k>", "<CMD>lua _G.float_documentation()<CR>", keymap_opts)
keymap("n", "<M-k>", "<CMD>lua _G.preview_documentation()<CR>", keymap_opts)

function _G.check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local keymap_opts_coc = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keymap(
  "i",
  "<TAB>",
  "coc#pum#visible() ? coc#pum#next(1) : "..
  "coc#jumpable() ? coc#snippet#next() : "..
  "v:lua.check_back_space() ? '<TAB>' : "..
  "coc#refresh()",
  keymap_opts_coc
)
keymap(
  "i",
  "<S-TAB>",
  "coc#pum#visible() ? coc#pum#prev(1) : "..
  "coc#jumpable() ? coc#snippet#prev() : "..
  "'<C-h>'",
  keymap_opts_coc
)
keymap(
  "i",
  "<CR>",
  "pumvisible() ? coc#_select_confirm() : "..
  "coc#pum#visible() ? coc#pum#confirm() : "..
  "'<C-g>u<CR><c-r>=coc#on_enter()<CR>'",
  keymap_opts_coc
)

-- scroll floats/popups in insert mode
keymap(
  "i",
  "<C-b>",
  "coc#float#has_scroll() ? '<c-r>=coc#float#scroll(1)<cr>' : '<Left>'",
  { silent = true, nowait = true, noremap = true, expr = true, replace_keycodes = false }
)
keymap(
  "i",
  "<C-f>",
  "coc#float#has_scroll() ? '<c-r>=coc#float#scroll(0)<cr>' : '<Right>'",
  { silent = true, nowait = true, noremap = true, expr = true, replace_keycodes = false }
)

keymap("i", "<c-space>", "coc#refresh()", keymap_opts_coc)

keymap("n", "<leader>gd", "<Plug>(coc-definition)",      keymap_opts)
keymap("n", "<leader>gr", "<Plug>(coc-references)",      keymap_opts)
keymap("n", "<leader>g[", "<Plug>(coc-diagnostic-prev)", keymap_opts)
keymap("n", "<leader>g]", "<Plug>(coc-diagnostic-next)", keymap_opts)
keymap("n", "<leader>e",  "<Plug>(coc-diagnostic-info)", keymap_opts)
keymap("n", "<leader>c",  "<Plug>(coc-codeaction-line)", keymap_opts)
keymap("n", "<leader>rn", "<Plug>(coc-rename)",          keymap_opts)
keymap("n", "<leader>rf", "<Plug>(coc-refactor)",        keymap_opts)
-- use gq with the formatwexpr autocmd up ahead
-- keymap("n", "<leader>f",  "<Plug>(coc-format-selected)", keymap_opts_coc)
-- keymap("x", "<leader>f",  "<Plug>(coc-format-selected)", keymap_opts_coc)

function _G.toggle_outline()
  local winid = vim.fn["coc#window#find"]("cocViewId", "OUTLINE")
  if winid == -1 then
    vim.fn.CocActionAsync("showOutline", 1)
  else
    vim.fn["coc#window#close"](winid)
  end
end
keymap("n", "_", "<CMD>lua _G.toggle_outline()<CR>", keymap_opts)

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("FileType",
  {
    desc = "Setup formatexpr specified filetypes",
    group = "CocGroup",
    pattern = "go,python,lua,json",
    command = "setl formatexpr=CocAction('formatSelected')",
  }
)
vim.api.nvim_create_autocmd("User",
  {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
  }
)

-- vim.api.nvim_create_autocmd("CursorHold",
--   {
--     group = "CocGroup",
--     pattern = "*",
--     command = "silent call CocActionAsync('highlight')"
--   }
-- )
