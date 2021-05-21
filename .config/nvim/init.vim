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

"    ___  __          _
"   / _ \/ /_ _____ _(_)__  ___
"  / ___/ / // / _ `/ / _ \(_-<
" /_/  /_/\_,_/\_, /_/_//_/___/
"             /___/

call plug#begin('~/.vim/plugged')
	Plug 'itchyny/lightline.vim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'joshdick/onedark.vim'
	"Plug 'mg979/vim-visual-multi'
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'sheerun/vim-polyglot'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'tpope/vim-surround'
call plug#end()

filetype plugin indent on
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"   _____                      __  ____    __  __  _
"  / ___/__ ___  ___ _______ _/ / / __/__ / /_/ /_(_)__  ___ ____
" / (_ / -_) _ \/ -_) __/ _ `/ / _\ \/ -_) __/ __/ / _ \/ _ `(_-<
" \___/\__/_//_/\__/_/  \_,_/_/ /___/\__/\__/\__/_/_//_/\_, /___/
"                                                      /___/

filetype off
set clipboard+=unnamedplus
set cmdheight=1
set cursorline
set encoding=UTF-8
set hidden
set incsearch
set list lcs=tab:\|\ 
set mouse=niv
set nobackup
set nocompatible
set noet ci pi sts=0 sw=4 ts=4
set noruler
set noshowcmd
set noshowmode
set noswapfile
set nowritebackup
set number relativenumber
set path+=**
set smartcase
set title
set updatetime=300
set wildmenu
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

"    ___  __          _        _____          ____
"   / _ \/ /_ _____ _(_)__    / ___/__  ___  / _(_)__ ____
"  / ___/ / // / _ `/ / _ \  / /__/ _ \/ _ \/ _/ / _ `(_-<
" /_/  /_/\_,_/\_, /_/_//_/  \___/\___/_//_/_//_/\_, /___/
"             /___/                             /___/

" itchyny/lightline.vim
let lightline={
		\ 'colorscheme': 'onedark',
		\ }
set laststatus=2

" joshdick/onedark.vim
let onedark_terminal_italics=1
syntax on
colorscheme onedark

" mg979/vim-visual-multi

" norcalli/nvim-colorizer.lua
lua require'colorizer'.setup()

" preservim/nerdtree
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
	\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
	\ quit | endif

"let NERDTreeDirArrowCollapsible=''
"let NERDTreeDirArrowExpandable=''
let NERDTreeDirArrowCollapsible=''
let NERDTreeDirArrowExpandable=''
let NERDTreeMinimalMenu=1
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeSortHiddenFirst=1
let NERDTreeWinSize=32
let plug_window='noautocmd vertical topleft new'
nnoremap <C-t> :NERDTreeToggle<CR>

" tiagofumo/vim-nerdtree-syntax-highlight
let NERDTreeExactMatchHighlightFullName=1
let NERDTreeFileExtensionHighlightFullName=1
let NERDTreeLimitedSyntax=1
let NERDTreePatternMatchHighlightFullName=1

" ryanoasis/vim-devicons
let WebDevIconsNerdTreeAfterGlyphPadding=' '
let WebDevIconsNerdTreeGitPluginForceVAlign=0
let WebDevIconsUnicodeDecorateFolderNodes=1
let DevIconsEnableFoldersOpenClose=1
let WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''
let DevIconsDefaultFolderOpenSymbol=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols={}
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['go']='ﳑ'
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['class']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['clj']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cljc']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['gradle']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jar']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['java']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cjs']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mjs']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jl']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['lua']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['xls']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['xlsx']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ppt']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pptx']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['doc']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['docx']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pl']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pm']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pod']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['php']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rmd']='ﳒ'
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rb']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rs']=''
let WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['swift']=''

"    ___                        __ __
"   / _ \___ __ _  ___ ____    / //_/__ __ _____
"  / , _/ -_)  ' \/ _ `/ _ \  / ,< / -_) // (_-<
" /_/|_|\__/_/_/_/\_,_/ .__/ /_/|_|\__/\_, /___/
"                    /_/              /___/

imap ii <Esc>
nmap <silent> <C-a> gg v G $
nmap <silent> <C-s> :w<CR>
nmap <silent> <F6> :setlocal spell spelllang=en_gb,es_mx<CR>
nmap <silent> Q gqap
nmap S :%s///g<Left><Left><Left>
vmap <silent> <F9> :sort<CR>
vmap <silent> Q gq

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

set splitbelow splitright

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <Leader>th <C-w>t<C-w>H
nmap <Leader>tk <C-w>t<C-w>K

nmap <silent> <C-Left> :vertical resize +4<CR>
nmap <silent> <C-Right> :vertical resize -4<CR>
nmap <silent> <C-Up> :resize +2<CR>
nmap <silent> <C-Down> :resize -2<CR>

nmap <Leader>th <C-w>t<C-w>H
nmap <Leader>tk <C-w>t<C-w>K