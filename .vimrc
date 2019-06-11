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
	set undodir=~/.vim/undodir
	set undofile
catch
endtry

"═══════════════════════════════════════════════════"
"                      ╠ VUNDLE ╣                   "
"═══════════════════════════════════════════════════"

filetype off                       " required! vundle needs filetype off before starting.
set rtp+=~/.vim/bundle/Vundle.vim  " set the runtime path to include Vundle
call vundle#begin()                " initialise vundle

"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
"            ♠ PLUGINS ♠           "
"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"

Plugin 'VundleVim/Vundle.vim'   " required! lets vundle manage vundle

" Utility
Plugin 'scrooloose/nerdtree'    " file tree
Plugin 'tpope/vim-fugitive'     " GIT integration
Plugin 'jiangmiao/auto-pairs'   " ident completition
Plugin 'tpope/vim-commentary'   " comment out lines with ease

" Syntax
Plugin 'w0rp/ale'
	" HTML
	Plugin 'mattn/emmet-vim'             " enmet integration to Vim
	" JavaScript
	Plugin 'pangloss/vim-javascript'     " JavaScript highlighting
	" TypeScript
	Plugin 'leafgarland/typescript-vim'  " TypeScript highlighting

" Visual
Plugin 'vim-airline/vim-airline'                   " bottom statusline
Plugin 'morhetz/gruvbox'                           " colour scheme
Plugin 'junegunn/goyo.vim'                         " distraction-free coding
Plugin 'junegunn/limelight.vim' " enhance goyo experience

call vundle#end()            " required! stops vundle
filetype plugin indent on    " required! re-enables filetype

"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
"         ♠ CONFIGURATION ♠        "
"▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"

" ALE
let g:ale_completion_enabled = 1           " enable auto-completion
set omnifunc=ale#completion#OmniFunc       " omni completion
let g:airline#extensions#ale#enabled = 1   " ale + vim-airline
set ballooneval                            " required! enable ballons!
set balloonevalterm                        " required! on terminals?
let g:ale_set_balloons = 1                 " enable balloons with ale
let g:ale_set_quickfix = 1                 " enables ale's quickfix
let g:ale_fix_on_save = 1                  " let ale fix certain issues upon saving
let g:ale_fixers = {
			\'*': ['remove_trailing_lines', 'trim_whitespace'],
			\'html': ['tidy'],
			\'javascript': ['prettier'],
			\'json': ['prettier'],
			\'markdown': ['prettier'],
			\'typescript': ['tslint'],
			\}

" goyo.vim
let g:goyo_width = "80%"

" gruvbox
let g:gruvbox_contrast_dark = 'hard'    " changes the contrast of dark mode
let g:gruvbox_contrast_light = 'hard'   " changes the contrast of light mode

" vim air-line
let g:airline_powerline_fonts =1

" vim-javascript
let g:javascript_plugin_jsdoc = 1 " Enable JSDoc highlighting

"═══════════════════════════════════════════════════"
"                    ╠ Interface ╣                  "
"═══════════════════════════════════════════════════"

set complete=.,w,b,u,kspell     " where to scan for completion
set completeopt=menuone,preview " completion (text) settings
set hidden                      " makes vim have buffers in the background without a window
set esckeys                     " allow cursor keys in insert mode
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set ignorecase                  " ignore case when searching
set magic                       " for regular expressions turn magic on
set splitright                  " split vertically to the right
set nostartofline               " do not reset cursor to start of line when moving around
set number                      " enable line numbers
set lines=50 columns=150        " windows size at startup
set foldmethod=indent           " enables folding based on indentation

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

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11 " editor font
                                                   " https://github.com/powerline/fonts/tree/master/DejaVuSansMono "
set background=dark                              " set the colourscheme theme to dark

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

"   NERDTREE   "

" Toggle NERDTree
nmap <silent> <leader>n :NERDTreeToggle<cr>

" Open NERDTree while finding and revealing the active buffer
nmap <silent> <leader>nf :NERDTreeFind<cr>

"══════════════"

"   ALE   "

" Move between definitions
nmap <leader>ad :ALEGoToDefinitionInVSplit<cr>

" Move between errors
nmap <silent> <c-k> <Plug>(ale_previous_wrap)
nmap <silent> <c-j> <Plug>(ale_next_wrap)

"═════════"

"   GOYO   "

" Start goyo.vim
nmap <silent> <leader>go :Goyo<cr>
nmap <silent> <leader>gs :Goyo!<cr>:e<cr>

" Start goyo.vim with limelight.vim
nmap <silent> <leader>gol :Goyo<cr>:Limelight<cr>
nmap <silent> <leader>gsl :Goyo!<cr>:Limelight!<cr>:e<cr>

"══════════"

" Move between buffers
nnoremap <S-k> :bprevious<cr>
nnoremap <S-j> :bnext<cr>

" Move between tabs
nnoremap <A-k> :tabprevious<cr>
nnoremap <A-j> :tabnext<cr>

" Add paste toggle
set pastetoggle=<F2>

" Disable highlights
map <silent> <leader><leader><cr> :noh<cr>

" Enable spell checking
map <leader>sc :setlocal<space>spell!<cr>
