"   __  __          ___ ____     __   _ __    _____     __
"  / / / /__ ___   |_  / / /____/ /  (_) /_  / ___/__  / /__  __ ______
" / /_/ (_-</ -_) / __/_  _/___/ _ \/ / __/ / /__/ _ \/ / _ \/ // / __/
" \____/___/\__/ /____//_/    /_.__/_/\__/  \___/\___/_/\___/\_,_/_/

if (empty($TMUX))
	if (has("nvim"))
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	if (has("termguicolors"))
		set termguicolors
	endif
endif

if &shell =~# 'fish$'
	set shell=sh
endif

"    ___  __          _
"   / _ \/ /_ _____ _(_)__  ___
"  / ___/ / // / _ `/ / _ \(_-<
" /_/  /_/\_,_/\_, /_/_//_/___/
"             /___/

lua <<EOF
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use 'hoob3rt/lualine.nvim'
	use 'jiangmiao/auto-pairs'
	use 'navarasu/onedark.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'preservim/nerdtree'
	use 'tpope/vim-surround'
	use 'tiagofumo/vim-nerdtree-syntax-highlight'
	use 'ryanoasis/vim-devicons'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
EOF

"   _____                      __  ____    __  __  _
"  / ___/__ ___  ___ _______ _/ / / __/__ / /_/ /_(_)__  ___ ____
" / (_ / -_) _ \/ -_) __/ _ `/ / _\ \/ -_) __/ __/ / _ \/ _ `(_-<
" \___/\__/_//_/\__/_/  \_,_/_/ /___/\__/\__/\__/_/_//_/\_, /___/
"                                                      /___/

lua <<EOF
vim.bo.copyindent = true
vim.bo.expandtab = false
vim.bo.modeline = false
vim.bo.preserveindent = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 0
vim.bo.swapfile = false
vim.bo.tabstop = 4
vim.o.backup = false
vim.o.clipboard = "unnamed,unnamedplus"
vim.o.cmdheight = 1
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.listchars = "extends:,precedes:,eol:,tab:│ "
vim.o.mouse = "niv"
vim.o.ruler = false
vim.o.scrolloff = 4
vim.o.showcmd = false
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.smartcase = true
vim.o.title = true
vim.o.updatetime = 100
vim.o.visualbell = true
vim.o.wildignore = "*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.swp,*~,._*,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*"
vim.o.wildmode = "longest,list,full"
vim.o.writebackup = false
vim.wo.cursorline = true
vim.wo.foldenable = false
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldmethod = "expr"
vim.wo.foldnestmax = 3
vim.wo.list = true
vim.wo.number = true
vim.wo.relativenumber = true
EOF
set guioptions=a
set iskeyword+=-
set path+=**
set shortmess+=cA

"Fix sizing bug with Alacritty terminal
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Auto reload if file was changed somewhere else (for autoread)
autocmd CursorHold * checktime

"    ___  __          _        _____          ____
"   / _ \/ /_ _____ _(_)__    / ___/__  ___  / _(_)__ ____
"  / ___/ / // / _ `/ / _ \  / /__/ _ \/ _ \/ _/ / _ `(_-<
" /_/  /_/\_,_/\_, /_/_//_/  \___/\___/_//_/_//_/\_, /___/
"             /___/                             /___/

" hoob3rt/lualine.nvim
lua <<EOF
require('lualine').setup {
	options = {
		component_separators = '',
		section_separators = '',
		theme = 'onedark'
	}
}
EOF

" lukas-reineke/indent-blankline.nvim
"let g:indent_blankline_use_treesitter=v:true
"let g:indent_blankline_char='│'

" navarasu/onedark.nvim
lua <<EOF
require('onedark').setup {
	style = 'darker'
}
require('onedark').load()
EOF

" norcalli/nvim-colorizer.lua
lua <<EOF
require'colorizer'.setup()
EOF

"nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "bash", "c", "cpp", "css", "fish", "html", "lua", "python", "toml", "vim", "yaml" },
	highlight = { enable = true },
	indent = { enable = true }
}
EOF


" preservim/nerdtree
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
	\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
	\ quit | endif

lua <<EOF
--vim.g.NERDTreeDirArrowCollapsible = ""
--vim.g.NERDTreeDirArrowExpandable = ""
vim.g.NERDTreeDirArrowCollapsible = ""
vim.g.NERDTreeDirArrowExpandable = ""
vim.g.NERDTreeMinimalMenu = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeMouseMode = 2
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeSortHiddenFirst = 1
vim.g.NERDTreeWinSize = 32
vim.g.plug_window = "noautocmd vertical topleft new"
vim.api.nvim_set_keymap("n", "<C-t>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
EOF

" tiagofumo/vim-nerdtree-syntax-highlight
lua <<EOF
vim.g.NERDTreeExactMatchHighlightFullName = 1
vim.g.NERDTreeFileExtensionHighlightFullName = 1
vim.g.NERDTreeLimitedSyntax = 1
vim.g.NERDTreePatternMatchHighlightFullName = 1
EOF

" ryanoasis/vim-devicons
let WebDevIconsNerdTreeAfterGlyphPadding = " "
let WebDevIconsNerdTreeGitPluginForceVAlign = 0
let WebDevIconsUnicodeDecorateFolderNodes = 1
let DevIconsEnableFoldersOpenClose = 1
let WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ""
let DevIconsDefaultFolderOpenSymbol = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['go'] = "ﳑ"
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['class'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['clj'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cljc'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['gradle'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jar'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['java'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cjs'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mjs'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jl'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['lua'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['xls'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['xlsx'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ppt'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pptx'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['doc'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['docx'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pl'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pm'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pod'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['php'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rmd'] = "ﳒ"
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rb'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rs'] = ""
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['swift'] = ""

"    ___                        __ __
"   / _ \___ __ _  ___ ____    / //_/__ __ _____
"  / , _/ -_)  ' \/ _ `/ _ \  / ,< / -_) // (_-<
" /_/|_|\__/_/_/_/\_,_/ .__/ /_/|_|\__/\_, /___/
"                    /_/              /___/

lua <<EOF
vim.api.nvim_set_keymap("i", "<C-s>", "<ESC>:w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "ii", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-a>", "gg v G $", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F6>", ":setlocal spell spelllang=en_gb,es_mx<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Q", "gqap", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "S", ":%s///g<Left><Left><Left>", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F9>", ":sort<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "Q", "gq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "S", ":s///g<Left><Left><Left>", { noremap = true })
EOF

"    ___       _ __   __  ____         __
"   / _ )__ __(_) /__/ / / __/_ _____ / /____ __ _
"  / _  / // / / / _  / _\ \/ // (_-</ __/ -_)  ' \
" /____/\_,_/_/_/\_,_/ /___/\_, /___/\__/\__/_/_/_/
"                          /___/

autocmd Filetype rmd,Rmd nmap <C-b> :!Rscript -e "rmarkdown::render('%', clean=TRUE)"<CR>

"    ____     ___ __        ____      ______     __   __          __
"   / __/__  / (_) /____   / __/___  /_  __/__ _/ /  / /  ___ ___/ /
"  _\ \/ _ \/ / / __(_-<   > _/_ _/   / / / _ `/ _ \/ _ \/ -_) _  /
" /___/ .__/_/_/\__/___/  |_____/    /_/  \_,_/_.__/_.__/\__/\_,_/
"    /_/
"    _____ __
"   / __(_) /__ ___
"  / _// / / -_|_-<
" /_/ /_/_/\__/___/

lua <<EOF
vim.o.splitbelow = true
vim.o.splitright = true

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>nw", ":set list nowrap<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>w", ":set list wrap<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>th", "<C-w>t<C-w>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>tk", "<C-w>t<C-w>K", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize +4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize -4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true })
EOF
