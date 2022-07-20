-- *****************************************************************************
-- Plug install packages
-- *****************************************************************************
require("paq") {
    "savq/paq-nvim",
    "lukas-reineke/indent-blankline.nvim",
    "navarasu/onedark.nvim",
    "norcalli/nvim-colorizer.lua",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    {"echasnovski/mini.nvim", branch = "stable"},
}

-- *****************************************************************************
-- Basic Setup
-- *****************************************************************************"
-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"

-- Fix backspace indent
vim.opt.backspace = {"indent", "eol", "start"}

-- Tabs. May be overridden by autocmd rules
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Map leader to ,
vim.g.mapleader = ","

-- Enable hidden buffers
vim.opt.hidden = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.fileformats = {"unix", "dos", "mac"}
vim.opt.nrformats:remove{"octal"}
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.history = 1000
vim.opt.tabpagemax = 50
vim.opt.sessionoptions:prepend{"options"}
vim.opt.viewoptions:prepend{"options"}

-- vim.opt.shell="/bin/fish"

-- not commenting on newline
vim.opt.formatoptions:remove{"cro"}

-- session management
vim.g.session_directory = "~/.config/nvim/session"
vim.g.session_autoload = "no"
vim.g.session_autosave = "no"
vim.g.session_command_aliases = 1

-- *****************************************************************************
-- Visual Settings
-- *****************************************************************************
vim.opt.termguicolors = true
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.display:append{"lastline"}
vim.opt.listchars = {
    eol = "",
    extends = "",
    nbsp = "+",
    precedes = "",
    tab = "│ ",
    trail = "-",
}
vim.opt.list = true

vim.opt.wrap = true
vim.opt.wrapmargin = 2
vim.opt.textwidth = 80

vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.no_buffers_menu = 1

-- Better command line completion
vim.opt.wildmenu = true

-- mouse support
vim.opt.mouse = "a"

vim.opt.mousemodel = "popup"
vim.opt.guioptions = "egmrti"
vim.opt.guifont = "Iosevka david35mm 10"

-- Disable the blinking cursor.
vim.opt.guicursor = {a = "blinkon0"}

-- Status bar
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.showmode = false

-- Use modeline overrides
vim.opt.modeline = true
vim.opt.modelines = 10

vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

vim.opt.statusline = "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set("n", "n", "nzzzv", {noremap = true})
vim.keymap.set("n", "N", "Nzzzv", {noremap = true})

-- *****************************************************************************
-- Abbreviations
-- *****************************************************************************
-- no one is really happy until you have this shortcuts
-- cnoreabbrev W! w!
-- cnoreabbrev Q! q!
-- cnoreabbrev Qall! qall!
-- cnoreabbrev Wq wq
-- cnoreabbrev Wa wa
-- cnoreabbrev wQ wq
-- cnoreabbrev WQ wq
-- cnoreabbrev W w
-- cnoreabbrev Q q
-- cnoreabbrev Qall qall
--
-- terminal emulation
vim.keymap.set(
    "n", "<leader>sh", ":terminal<CR>", {noremap = true, silent = true})

-- *****************************************************************************
-- Autocmd Rules
-- *****************************************************************************

-- Remember cursor position
vim.cmd(
    [[
    augroup vimrc-remember-cursor-position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END
]])

-- Fix Alacritty sizing bug
vim.cmd(
    [[
    augroup vimrc-fix-sizing-bug-alacritty
        autocmd!
        autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
    augroup END
]])

-- Remove trailing whitespaces
vim.cmd(
    [[
    augroup vimrc-delete-trailing-whitespace-newlines
        autocmd!
        autocmd BufWritePre * %s/\s\+$//e
        autocmd BufWritePre * %s/\n\+\%$//e
        autocmd BufWritePre *.[ch] %s/\%$/\r/e
    augroup END
]])

-- make/cmake
vim.cmd(
    [[
    augroup vimrc-make-cmake
        autocmd!
        autocmd FileType make setlocal noexpandtab
        autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
    augroup END
]])

-- Reload file
vim.cmd(
    [[
    augroup vimrc-autoreload-file
        autocmd!
        autocmd CursorHold * checktime
    augroup END
]])

vim.opt.autoread = true

-- *****************************************************************************
-- Mappings
-- *****************************************************************************
-- Exit insert mode
vim.keymap.set("i", "ii", "<Esc>l", {noremap = true})

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set("", "<Leader>h", ":<C-u>split<CR>", {noremap = true})
vim.keymap.set("", "<Leader>v", ":<C-u>vsplit<CR>", {noremap = true})

-- Resize Splits
vim.keymap.set("", "<C-Left>", ":vertical resize +4<CR>",
               {noremap = true, silent = true})
vim.keymap.set("", "<C-Right>", ":vertical resize -4<CR>",
               {noremap = true, silent = true})
vim.keymap.set("", "<C-Up>", ":resize +2<CR>", {noremap = true, silent = true})
vim.keymap.set("", "<C-Down>", ":resize -2<CR>",
               {noremap = true, silent = true})
--
-- Git
-- noremap <Leader>ga :Gwrite<CR>
-- noremap <Leader>gc :Git commit --verbose<CR>
-- noremap <Leader>gsh :Git push<CR>
-- noremap <Leader>gll :Git pull<CR>
-- noremap <Leader>gs :Git<CR>
-- noremap <Leader>gb :Git blame<CR>
-- noremap <Leader>gd :Gvdiffsplit<CR>
-- noremap <Leader>gr :GRemove<CR>
--
-- session management
-- nnoremap <leader>so :OpenSession<Space>
-- nnoremap <leader>ss :SaveSession<Space>
-- nnoremap <leader>sd :DeleteSession<CR>
-- nnoremap <leader>sc :CloseSession<CR>

-- Wrap
vim.keymap.set(
    "", "<Leader>nw", ":set list nowrap<CR>", {noremap = true, silent = true})
vim.keymap.set(
    "", "<Leader>yw", ":set list wrap<CR>", {noremap = true, silent = true})
--
-- Tabs
vim.keymap.set("n", "<Tab>", "gt", {noremap = true})
vim.keymap.set("n", "<S-Tab>", "gT", {noremap = true})
vim.keymap.set("n", "<S-t>", ":tabnew<CR>", {noremap = true, silent = true})
--
-- Set working directory
vim.keymap.set("n", "<leader>.", ":lcd %:p:h<CR>", {noremap = true})
--
-- Opens an edit command with the path of the currently edited file filled in
vim.keymap.set(
    "", "<Leader>e", ":e <C-R>=expand(\"%:p:h\") . \"/\" <CR>", {noremap = true})
--
-- Opens a tab edit command with the path of the currently edited file filled
vim.keymap.set(
    "", "<Leader>te", ":tabe <C-R>=expand(\"%:p:h\") . \"/\" <CR>",
    {noremap = true})
--
-- fzf.vim
-- vim.opt.wildmode=list:longest,list:full
-- vim.opt.wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
-- let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
--
-- The Silver Searcher
-- if executable('ag')
-- let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
-- vim.opt.grepprg=ag\ --nogroup\ --nocolor
-- endif
--
-- ripgrep
-- if executable('rg')
-- let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
-- vim.opt.grepprg=rg\ --vimgrep
-- command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
-- endif
--
-- cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
-- nnoremap <silent> <leader>b :Buffers<CR>
-- nnoremap <silent> <leader>e :FZF -m<CR>
-- "Recovery commands from history through FZF
-- nmap <leader>y :History:<CR>
--
-- snippets
-- let g:UltiSnipsExpandTrigger="<tab>"
-- let g:UltiSnipsJumpForwardTrigger="<tab>"
-- let g:UltiSnipsJumpBackwardTrigger="<c-b>"
-- let g:UltiSnipsEditSplit="vertical"
--
-- ale
-- let g:ale_linters = {}
--
-- Tagbar
-- nmap <silent> <F4> :TagbarToggle<CR>
-- let g:tagbar_autofocus = 1
--
-- Disable visualbell
-- vim.opt.noerrorbells visualbell t_vb=
-- if has('autocmd')
-- autocmd GUIEnter * vim.opt.visualbell t_vb=
-- endif
--
-- Copy/Paste/Cut
vim.opt.clipboard = {"unnamed", "unnamedplus"}
--
vim.keymap.set("", "YY", "\"+y<CR>", {noremap = true})
vim.keymap.set("", "<leader>p", "\"+gP<CR>", {noremap = true})
vim.keymap.set("", "XX", "\"+x<CR>", {noremap = true})
--
-- Buffer nav
vim.keymap.set("", "<leader>z", ":bprevious<CR>", {noremap = true})
vim.keymap.set("", "<leader>q", ":bprevious<CR>", {noremap = true})
vim.keymap.set("", "<leader>x", ":bnext<CR>", {noremap = true})
vim.keymap.set("", "<leader>w", ":bnext<CR>", {noremap = true})
--
-- Close buffer
vim.keymap.set("", "<leader>c", ":bdelete<CR>", {noremap = true})
--
-- Clean search (highlight)
vim.keymap.set(
    "n", "<leader><space>", ":noh<cr>", {noremap = true, silent = true})
--
-- Switching windows
vim.keymap.set("", "<C-j>", "<C-w>j", {noremap = true})
vim.keymap.set("", "<C-k>", "<C-w>k", {noremap = true})
vim.keymap.set("", "<C-l>", "<C-w>l", {noremap = true})
vim.keymap.set("", "<C-h>", "<C-w>h", {noremap = true})
vim.keymap.set("", "<Leader>th", "<C-w>t<C-w>H", {noremap = true})
vim.keymap.set("", "<Leader>tk", "<C-w>t<C-w>K", {noremap = true})
--
-- Vmap for maintain Visual Mode after shifting > and <
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
--
-- Move visual block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {noremap = true})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {noremap = true})

-- Common Keybindings
--vim.keymap.set

-- *****************************************************************************
-- Custom configs
-- *****************************************************************************
--
-- c
-- vim.cmd([[
--     augroup vimrc-filetype-settings
--         autocmd!
--         autocmd FileType lua,python setlocal expandtab ts=4 sw=4
--     augroup END
-- ]])

vim.cmd([[
    augroup vimrc-syntax-settings
        autocmd!
        autocmd BufNewFile,BufRead *.conf set ft=toml
        autocmd BufNewFile,BufRead *.rasi set ft=css
    augroup END
]])

-- *****************************************************************************
-- Plugin Settings
-- *****************************************************************************
require("colorizer").setup()

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

require("mini.comment").setup {
    mappings = {comment = "gc", comment_line = "gcc", textobject = "gc"},
    hooks = {pre = function() end, post = function() end},
}

require("mini.pairs").setup {
    modes = {insert = true, command = false, terminal = false},
    mappings = {
        ["("] = {action = "open", pair = "()", neigh_pattern = "[^\\]."},
        ["["] = {action = "open", pair = "[]", neigh_pattern = "[^\\]."},
        ["{"] = {action = "open", pair = "{}", neigh_pattern = "[^\\]."},
        [")"] = {action = "close", pair = "()", neigh_pattern = "[^\\]."},
        ["]"] = {action = "close", pair = "[]", neigh_pattern = "[^\\]."},
        ["}"] = {action = "close", pair = "{}", neigh_pattern = "[^\\]."},
        ["\""] = {
            action = "closeopen",
            pair = "\"\"",
            neigh_pattern = "[^\\].",
            register = {cr = false},
        },
        ["'"] = {
            action = "closeopen",
            pair = "''",
            neigh_pattern = "[^%a\\].",
            register = {cr = false},
        },
        ["`"] = {
            action = "closeopen",
            pair = "``",
            neigh_pattern = "[^\\].",
            register = {cr = false},
        },
    },
}

-- require("mini.statusline").setup {
--     content = {
--         active = nil,
--         inactive = nil,
--     },
--     use_icons = false,
--     set_vim_settings = false,
-- }

require("mini.surround").setup {
    custom_surroundings = nil,
    highlight_duration = 500,
    mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
    },
    n_lines = 20,
    search_method = "cover",
}

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "css",
        "fish",
        "go",
        "html",
        "javascript",
        "lua",
        "make",
        "python",
        "toml",
        "vim",
        "yaml",
    },
    highlight = {enable = true},
    indent = {enable = true},
}

require("onedark").setup {style = "darker"}
require("onedark").load()

require("lualine").setup {
    options = {theme = "onedark", globalstatus = true},
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics", "filesize"},
        lualine_c = {"filename"},
        lualine_x = {"filetype", "encoding", "fileformat"},
        lualine_y = {"progress"},
        lualine_z = {"location"},
    },
}
