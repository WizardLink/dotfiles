"═══════════════════════════════════════════════════"
"                     ╠ GENERAL ╣                   "
"═══════════════════════════════════════════════════"

set nocompatible    " disables backwards compatibility with Vi
set encoding=utf-8  " sets encoding to utf-8

" Removes the rather annoying bar in GVIM
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set guitablabel=%M\ %t
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
Plugin 'scrooloose/nerdtree'    " File Tree
Plugin 'tpope/vim-fugitive'     " GIT Integration
Plugin 'jiangmiao/auto-pairs'   " Ident completition

" Syntax
Plugin 'w0rp/ale'
	" HTML
	Plugin 'mattn/emmet-vim'             " enmet integration to Vim
	" JavaScript
	Plugin 'pangloss/vim-javascript'     " JavaScript highlighting
	" TypeScript
	Plugin 'leafgarland/typescript-vim'  " TypeScript highlighting

" Visual
Plugin 'vim-airline/vim-airline'  " Bottom statusline
Plugin 'morhetz/gruvbox'          " Colour scheme

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

set completeopt=longest,menuone " completion (text) settings
set hidden                      " makes vim have buffers in the background without a window
set esckeys                     " allow cursor keys in insert mode
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set whichwrap=b,s,h,l,<,>,[,]   " free tge cursor
set ignorecase                  " ignore case when searching
set magic                       " for regular expressions turn magic on
set splitright                  " split vertically to the right
set nostartofline               " do not reset cursor to start of line when moving around
set scrolloff=2                 " start scrolling at this number of lines from the bottom
set scrolloff=3                 " start scrolling three lines before the horizontal window border
set scrolloff=4                 " start scrolling horizontally at this number of columns
set number                      " enable line numbers
"set noerrorbell                " disable annoying error bells
set foldcolumn=0                " no extra margin to the left
set lines=50 columns=150        " windows size at startup

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
set mat=2             " how many tenths of a second to blink when matching brackets

"═══════════════════════════════════════════════════"
"               ╠ Colors and Fonts ╣                "
"═══════════════════════════════════════════════════"

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11 " editor font
                                                   " https://github.com/powerline/fonts/tree/master/DejaVuSansMono "

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
	try
		colorscheme gruvbox
		" sets colorscheme
	catch /^Vim\%((\a\+)\)\=:E185/
	" not available
	endtry

" Enable coloring for dark background terminals
if has('gui_running')
	set background=light
else
	set background=dark
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

" Highlight trailing spaces in annoying red
if has('autocmd')
	highlight ExtraWhitespace ctermbg=1 guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	if exists('*clearmatches')
		autocmd BufWinLeave * call clearmatches()
	endif
endif

" Reload .vimrc when saving it
if has("autocmd")
	autocmd BufWritePost .vimrc nested source %
endif

" Highlight conflict markers
	match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
endif

"═══════════════════════════════════════════════════"
"          ╠ Text, Tab and Indent related ╣         "
"═══════════════════════════════════════════════════"

" Insert spaces for tabs according to shiftwidth
if exists("+smarttab")
	set smarttab
endif

" Does nothing more than copy the indentation from the previous line,
" when starting a new line
if exists("+autoindent")
	set noautoindent
endif

" Automatically inserts one extra level of indentation in some cases
if exists("+smartindent")
	set smartindent
endif

" Tab indentation
set noexpandtab
set shiftwidth=4
set tabstop=4

set nojoinspaces      " use one space, not two, after punctuation
set fo-=t             " do not automatically wrap text when typing
set list              " enable list
set formatoptions+=n  " support for numbered/bullet lists

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

" NERDTREE
map <C-n> :NERDTreeToggle %<CR>

"   ALE   "

" Move between definitions
map <C-f> :ALEGoToDefinitionInVSplit<CR>

" Move between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"═════════"

" Move between buffers
nnoremap <S-k> :bprevious<CR>
nnoremap <S-j> :bnext<CR>

" Move between tabs
nnoremap <A-k> :tabprevious<CR>
nnoremap <A-j> :tabnext<CR>

" Add paste toggle
set pastetoggle=<F2>
