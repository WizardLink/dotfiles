"═══════════════════════════════════════════════════"
"                     ╠ GENERAL ╣                   "
"═══════════════════════════════════════════════════"

set nocompatible    " disables backwards compatibility with Vi
set encoding=utf8   " sets encoding to utf-8
scriptencoding utf8 " ^
set fileformat=unix " LF only
set termguicolors

" Change GVIM window
if has("gui_running")
	" Remove items from the GVIM
	set guioptions-=e        " GUI tab
	set guioptions-=m        " the menu bar
	set guioptions-=T        " the toolbar
	set guioptions-=r        " right scrollbar
	set guioptions-=R        " right scrollbar at vertical split windows
	set guioptions-=l        " left scrollbar
	set guioptions-=L        " left scrollbar at vertical split windows

	" Enable DirectX rendering
	set rop=type:directx,renmode:3
endif

" Set language as en_US in all circumstances for consistency
try
	lang en_US
catch
endtry

" Disable unsafe commands
set secure

" Add subfolders in the path
set path+=**

" Automatically change the current directory
set autochdir

" Confirmation dialog
set confirm

" Show the filename in the window titlebar
if exists("+title")
	set title
endif

" Return to last edit position when opening files
if has('viminfo')
	if has('autocmd')
		autocmd BufReadPost *\(.git/COMMIT_EDITMSG\)\@<!
					\ if line("'\"") > 0 && line("'\"") <= line("$") |
					\ 	exe "normal! g`\"" |
					\ endif
	endif
	" Remember info about open buffers on close
	set viminfo^=%
endif

" Persistent undo so you can undo even after buffer is closed
try
	set undodir=~/.vim/temp
	set backupdir=~/.vim/temp
	set directory=~/.vim/temp
	set undofile
catch
endtry

"═══════════════════════════════════════════════════"
"                    ╠ VIM-PLUG ╣                   "
"═══════════════════════════════════════════════════"
call plug#begin('~/.vim/plugins')   " initialise vim-plug

"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
"            ♠ PLUGINS ♠           "
"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"

" Utility
Plug 'tpope/vim-fugitive'            " GIT integration
Plug 'tpope/vim-commentary'          " comment out lines with ease
Plug 'liuchengxu/vim-clap'           " interactive fuzzy finder
Plug 'itchyny/lightline.vim'         " configurable statusline

" Completion
Plug 'ajh17/VimCompletesMe'          " tab completion

"  Syntax  "

Plug 'editorconfig/editorconfig-vim' " editorconfig VIM integration
Plug 'w0rp/ale'                      " syntax lint and lsp

" HTML
Plug 'mattn/emmet-vim'               " enmet integration to Vim

" JavaScript
Plug 'pangloss/vim-javascript'       " JavaScript highlighting

" TypeScript
Plug 'leafgarland/typescript-vim'    " TypeScript highlighting

" Elixir
Plug 'elixir-editors/vim-elixir'     " Elixir highlighting
Plug 'slashmili/alchemist.vim'       " ElixirSense

"  END-SYNTAX  "

" Visual
Plug 'morhetz/gruvbox'               " colour scheme

call plug#end()              " required! stops vim-plug
filetype plugin indent on    " required! re-enables filetype

"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
"         ♠ CONFIGURATION ♠        "
"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"

"  ALE  "

" General
let g:ale_completion_enabled = 1     " enable auto-completion

" OmniFunc + ALE
set omnifunc=ale#completion#OmniFunc " omni completion

" Fix
let g:ale_fix_on_save = 1            " let ale fix certain issues upon saving

" Lint
let g:ale_set_loclist = 1            " populate the loclist
let g:ale_lint_delay = 300           " change delay for linter to be ran
let g:ale_linters_explicit = 1       " only enable the specified linters

let g:ale_linters =
			\{
			\'cs': ['mcs'],
			\'javascript': ['eslint', 'tsserver'],
			\'javascriptreact': ['eslint', 'tsserver'],
			\'typescript': ['eslint', 'tsserver'],
			\'typescriptreact': ['eslint', 'tsserver'],
			\}

let g:ale_fixers =
			\{
			\'*': ['remove_trailing_lines','trim_whitespace'],
			\'cs': ['uncrustify'],
			\'html': ['tidy'],
			\'javascript': ['eslint'],
			\'javascriptreact': ['eslint'],
			\'markdown': ['prettier'],
			\'typescript': ['eslint'],
			\'typescriptreact': ['eslint'],
			\}

" END-ALE "

" gruvbox
let g:gruvbox_contrast_dark = 'soft'    " changes the contrast of dark mode
let g:gruvbox_contrast_light = 'soft'   " changes the contrast of light mode

"   lightline   "

let g:lightline =
			\{
			\ 'colorscheme': 'gruvbox',
			\ 'component': {
			\   'lineinfo': ' %3l:%-2v',
			\ },
			\ 'component_function': {
			\   'readonly': 'LightlineReadonly',
			\   'fugitive': 'LightlineFugitive'
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\}

function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction

" END LIGHTLINE "

" vim-javascript
let g:javascript_plugin_jsdoc = 1       " Enable JSDoc highlighting

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*'] " avoid conflicts with ssh and vim-fugitive
let g:EditorConfig_max_line_indicator = 'exceeding'                   " change the indicator, to highlight exceeding characters
let g:EditorConfig_preserve_formatoptions = 1                         " preserves the format else it gets annoying

" NETRW
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"═══════════════════════════════════════════════════"
"                    ╠ Interface ╣                  "
"═══════════════════════════════════════════════════"

set complete=.,w,b,u,kspell               " where to scan for completion
set completeopt+=noselect,longest,menuone " completion (text) settings
set completeopt-=preview
set shortmess+=c                          " shut off completion messages
set hidden                                " makes vim have buffers in the background without a window
set backspace=indent,eol,start            " allow backspacing over everything in insert mode
set ignorecase                            " ignore case when searching
set magic                                 " for regular expressions turn magic on
set nostartofline                         " do not start at the beginning of the line when moving
set nowrap                                " disables word wrapping
set autoindent                            " automatically indent on pase
set splitright                            " split vertically to the right
set wildmenu                              " enhanced command-line completion
set number                                " enable line numbers
set relativenumber                        " relative number to the line in focus
set foldmethod=indent                     " enables folding based on indentation
set updatetime=300                        " lower the update time for better experience
set signcolumn=yes                        " always show signcolumns
set visualbell                            " visual bell instead of sound
set nolazyredraw                          " do not re-draw the screen on macro
set noshowmode                            " ommit what mode you are

" Use intelligent case while searching
" (If search string contains an upper case letter, disables ignorecase)
set smartcase

" Makes search act like search in modern browsers
if exists("+incsearch")
	set incsearch
endif

"═══════════════════════════════════════════════════"
"              ╠ Parenthesis/Bracket ╣              "
"═══════════════════════════════════════════════════"

set showmatch         " show matching brackets when text indicator is over them
set matchpairs+=<:>   " include angle brackets in matching

"═══════════════════════════════════════════════════"
"               ╠ Colors and Fonts ╣                "
"═══════════════════════════════════════════════════"

set guifont=Fira\ Code:h11                         " editor font
                                                   " https://github.com/powerline/fonts/tree/master/DejaVuSansMono "
set background=dark                                " set the colourscheme theme to dark

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
	try
		colorscheme gruvbox
		" sets colorscheme
	catch /^Vim\%((\a\+)\)\=:E185/
	" not available
	endtry
endif

" Turn on color syntax highlighting
if exists("+syntax")
	syntax on
	" increases syntax accuracy
	syntax sync fromstart
endif

" Also switch on highlighting the last used search pattern
if exists("+hlsearch")
	set hlsearch
endif

" Highlight current line
if exists("+cursorline")
	set cursorline
endif

" Reload .vimrc when saving it
if has("autocmd")
	autocmd BufWritePost .vimrc nested source %
endif

"═══════════════════════════════════════════════════"
"          ╠ Text, Tab and Indent related ╣         "
"═══════════════════════════════════════════════════"

set nojoinspaces      " use one space, not two, after punctuation
set list              " enable list
set formatoptions+=n  " support for numbered/bullet lists

" Insert spaces for tabs according to shiftwidth
if exists("+smarttab")
	set smarttab
endif

" Automatically inserts one extra level of indentation in some cases
if exists("+smartindent")
	set smartindent
endif

" Tab indentation
set shiftwidth=4
set tabstop=4

" Set listchars special characters for eol, tab, etc.
set lcs=tab:›–,eol:¶,extends:‹,precedes:‡

"═══════════════════════════════════════════════════"
"                  ╠ Status line ╣                  "
"═══════════════════════════════════════════════════"

set laststatus=2    " always show the status line

" Show the (partial) command as it’s being typed.
if exists("+showcmd")
	set showcmd
endif

"═══════════════════════════════════════════════════"
"                   ╠ Key Binds ╣                   "
"═══════════════════════════════════════════════════"

" Set the <leader> to a better key
let mapleader = ","

"   ALE   "

" Show full linter message
nmap <leader>ald :ALEDetail<cr>

" Find definition
nmap <leader>adf :ALEGoToDefinition<cr>
nmap <leader>adt :ALEGoToDefinitionInTab<cr>
nmap <leader>atv :ALEGoToTypeDefinitionInVSplit<cr>
nmap <c-s-space> :ALEHover<cr>

"═════════"

" Change between dark and light mode
function ChangeBackground()
	if &background ==# 'dark'
		set background=light
	elseif &background ==# 'light'
		set background=dark
	endif
endfunction

nmap <silent> <leader>tc :call ChangeBackground()<cr>

"══════════"

" Move between buffers
nnoremap <a-k> :bnext<cr>
nnoremap <a-j> :bprevious<cr>

" Move between tabs
nnoremap <a-l> :tabnext<cr>
nnoremap <a-h> :tabprevious<cr>

" Move tab position
nnoremap <c-s-l> :+tabmove<cr>
nnoremap <c-s-h> :-tabmove<cr>

" Location list
nnoremap <silent> <leader>lo :lopen<cr>
nnoremap <silent> <leader>lc :lclose<cr>
nnoremap <silent> <leader>ln :lnext<cr>
nnoremap <silent> <leader>lp :lprevious<cr>

" Add paste toggle
set pastetoggle=<F2>

" Enable spell checking
map <leader>sc :setlocal spell!<cr>

" clap 👏
nnoremap <leader>cp :Clap<space>
nnoremap <silent> <leader>cb :Clap blines<cr>
nnoremap <silent> <leader>cf :Clap files<cr>
nnoremap <silent> <leader>cg :Clap grep<cr>

" remove highlights more quickly
nmap <silent> <leader>n :noh<cr>

" Open NETRW
nnoremap <silent> <leader>t :Vexplore<cr>
