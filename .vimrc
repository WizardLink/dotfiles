"═══════════════════════════════════════════════════"
"                     ╠ GENERAL ╣                   "
"═══════════════════════════════════════════════════"

set nocompatible    " disables backwards compatibility with Vi
set encoding=utf-8  " sets encoding to utf-8

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

	" Change the GVIM label
	set guitablabel=%M\ %t   "
endif

" Set language as en_US in all circumstances for consistency
try
	lang en_US
catch
endtry

" Force file format to LF
set fileformat=unix

" Disable unsafe commands
set secure

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
Plug 'tpope/vim-fugitive'              " GIT integration
Plug 'tpope/vim-commentary'            " comment out lines with ease
Plug 'ludovicchabant/vim-gutentags'    " tag manager

" Completion
Plug 'Shougo/deoplete.nvim'            " async completion
Plug 'roxma/nvim-yarp'                 " nvim compatibility layer
Plug 'roxma/vim-hug-neovim-rpc'        " nvim in vim

"  Syntax  "

Plug 'editorconfig/editorconfig-vim'   " editorconfig VIM integration
Plug 'w0rp/ale'                        " syntax checker and completion

" HTML
Plug 'mattn/emmet-vim'               " enmet integration to Vim

" JavaScript
Plug 'pangloss/vim-javascript'       " JavaScript highlighting

" TypeScript
Plug 'leafgarland/typescript-vim'    " TypeScript highlighting

"  END-SYNTAX  "

" Visual
Plug 'vim-airline/vim-airline'                   " bottom statusline
Plug 'morhetz/gruvbox'                           " colour scheme

call plug#end()              " required! stops vim-plug
filetype plugin indent on    " required! re-enables filetype

"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
"         ♠ CONFIGURATION ♠        "
"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"

"  ALE  "

" General
let g:airline#extensions#ale#enabled = 1   " ale + vim-airline

" Fix
let g:ale_fix_on_save = 1                  " let ale fix certain issues upon saving

" Lint
let g:ale_lint_delay = 100      " change delay for linter to be ran
let g:ale_linters_explicit = 1  " only enable the specified linters

let g:ale_linters =
			\{
			\'javascript': ['eslint'],
			\'typescript': ['eslint', 'tsserver']
			\}
let g:ale_fixers =
			\{
			\'*': ['remove_trailing_lines','trim_whitespace'],
			\'html': ['tidy'],
			\'javascript': ['eslint'],
			\'json': ['prettier'],
			\'markdown': ['prettier'],
			\'typescript': ['eslint'],
			\}

" END-ALE "

" deoplete
let g:deoplete#enable_at_startup = 1

" gutentags
let g:gutentags_cache_dir = '~/.vim/temp' " where to store tags

" gruvbox
let g:gruvbox_contrast_dark = 'soft'    " changes the contrast of dark mode
let g:gruvbox_contrast_light = 'soft'   " changes the contrast of light mode

" vim-javascript
let g:javascript_plugin_jsdoc = 1 " Enable JSDoc highlighting

" vim-airline
let g:airline_powerline_fonts = 1

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*'] " avoid conflicts with ssh and vim-fugitive
let g:EditorConfig_max_line_indicator = 'exceeding'                   " change the indicator, to highlight exceeding characters
let g:EditorConfig_preserve_formatoptions = 1                         " preserves the format else it gets annoying

"═══════════════════════════════════════════════════"
"                    ╠ Interface ╣                  "
"═══════════════════════════════════════════════════"

set complete=.,w,b,u,kspell     " where to scan for completion
set completeopt=menuone,preview " completion (text) settings
set hidden                      " makes vim have buffers in the background without a window
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set ignorecase                  " ignore case when searching
set magic                       " for regular expressions turn magic on
set splitright                  " split vertically to the right
set number                      " enable line numbers
set lines=50 columns=150        " windows size at startup
set foldmethod=indent           " enables folding based on indentation
set updatetime=300              " lower the update time for better experience
set signcolumn=yes              " always show signcolumns

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
set background=light                               " set the colourscheme theme to dark

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

" Set characters to show for trailing whitespace and
" end-of-line. Also supports tab, but I set expandtab
" and thus tabs are always turned into spaces
set listchars=eol:§,tab:¤›,extends:»,precedes:«,nbsp:‡

"═══════════════════════════════════════════════════"
"                  ╠ Status line ╣                  "
"═══════════════════════════════════════════════════"

set laststatus=2    " always show the status line

" Show current mode in the status line.
if exists("+showmode")
	set showmode
endif

" Show the (partial) command as it’s being typed.
if exists("+showcmd")
	set showcmd
endif

"═══════════════════════════════════════════════════"
"                   ╠ Key Binds ╣                   "
"═══════════════════════════════════════════════════"

" Set the <leader> to a better key
let mapleader = ","

"   NERDTREE   "

" Toggle NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<cr>

" Open NERDTree while finding and revealing the active buffer
nmap <silent> <leader>nf :NERDTreeFind<cr>

"══════════════"

"   ALE   "

" Show full linter message
nmap <leader>ald :ALEDEtail<cr>

" Find definition
nmap <leader>ad :ALEGoToDefinitionInVSplit<cr>
nmap <leader>atd :ALEGoToTypeDefinitionInVSplit<cr>

" Move between errors
nmap <c-j> <Plug>(ale_next_wrap)
nmap <c-k> <Plug>(ale_previous_wrap)

" Open location list
nmap <silent> <leader>ll :lopen<CR>
nmap <silent> <leader>lp :lprevious<cr>
nmap <silent> <leader>ln :lnext<cr>

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
nnoremap <S-k> :bprevious<cr>
nnoremap <S-j> :bnext<cr>

" Move between tabs
nnoremap <A-k> :tabprevious<cr>
nnoremap <A-j> :tabnext<cr>

" Add paste toggle
set pastetoggle=<F2>

" Enable spell checking
map <leader>sc :setlocal spell!<cr>
