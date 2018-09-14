"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   <> GENERAL <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make Vim more useful
set nocompatible

" Set the default shell
set shell=bash

" Tell vim to use the .vim path first
set runtimepath=~/.vim,$VIMRUNTIME

" Necessary for gnu screen & mouse
set ttymouse=xterm2

" Add the g flag to search/replace by default
set gdefault

" Ignore whitespace in vimdiff
if &diff
  set diffopt+=iwhite
endif

" Only look at this number of lines for modeline
set modelines=10

" Look for the embedded modelines at the top of the file
set modeline

" Enable filetype detection
filetype on

" Enable filetype-specific plugis
filetype plugin on

" Enable filetype-specific indenting
filetype indent on

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" Try to set right locale
try
  lang en_US
catch
endtry

" Tell vim to use the .vim path first.
set runtimepath=~/.vim,$VIMRUNTIME

" Set encoding
if has('multi_byte')
  scriptencoding utf-8
  set encoding=utf-8
  set fileencodings=utf-8,cp932,sjis,utf-16le,euc-jp

  if has("win32") || has("win64")
    set termencoding=gbk
  endif
  if has("linux") || has("unix")
    set termencoding=utf-8
  endif
endif

" None word dividers
set isk+=_,$,@,%,#,-

" Try to detect file formats
set fileformats=unix,dos,mac

" Enable per-directory .vimrc files
set exrc

" Disable unsafe commands
set secure

" Tell us about changes
set report=0

" Show the filename in the window titlebar
if exists("+title")
	set title
endif

" Automatically set/unset Vim's paste mode when you paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   <> VUNDLE <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Encoding for Vundle
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Utility
Plugin 'Valloric/YouCompleteMe' " Autocomplete
Plugin 'w0rp/ale' " Async Lint
Plugin 'scrooloose/nerdtree' " File Tree
Plugin 'tpope/vim-fugitive' " GIT Integration

" Visual
Plugin 'vim-airline/vim-airline' " Bottom status line
Plugin 'dracula/vim' " Colour Scheme

" Typescript
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  <> Interface <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Completetion (text) settings
set completeopt=longest,menuone

" Height of the command bar
set cmdheight=1

" GVIM
set guioptions-=T

" This makes vim act like other editors, buffers can exist in the
" background without being in a window
set hidden

" Allow cursor keys in insert mode
set esckeys

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Free tge cursor
set whichwrap=b,s,h,l,<,>,[,]

" Ignore case when searching
set ignorecase

" Use intelligent case while searching
" (If search string contains an upper case letter, disables ignorecase)
set smartcase

" Makes search act like search in modern browsers
if exists("+incsearch")
	set incsearch
endif

" For regular expressions turn magic on
set magic

" Split vertically to the right
set splitright

" Do not reset cursor to start of line when moving around
set nostartofline

" Show the cursor position
"if exists("+ruler")
"	set ruler
"endif

" Start scrolling at this number of lines from the bottom
set scrolloff=2

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Start scrolling horizontally at this number of columns
set sidescrolloff=4

" Enable line numbers (left)
set number

" No annoying sound on errors
set noerrorbells
set visualbell

" No extra margin to the left
set foldcolumn=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"            <> Parenthesis/Bracket <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show matching brackets when text indicator is over them
set showmatch

" Include angle brackets in matching
set matchpairs+=<:>

" How many tenths of a second to blink when matching brackets
set mat=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"             <> Colors and Fonts <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Editor font
set guifont=Consolas:h10:b 

" Windows size at startup
set lines=50 columns=200

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  try
    colorscheme dracula
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"          <> Files, backups and undo <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip trailing whitespaces automatically when saving files of certain type
if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.php,*.gpx,*.rb,*.tpl :call StripTrailingWhitespaces()
endif

" Don't backup files in temp directories or shm
if exists('&backupskip')
  set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" Don't keep swap files in temp directories or shm
if has('autocmd')
  augroup swapskip
    autocmd!
    silent! autocmd BufRead,BufNewFilePre
      \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
      \ setlocal noswapfile
  augroup END
endif

" Don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
 augroup undoskip
   autocmd!
   silent! autocmd BufWritePre
     \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
     \ setlocal noundofile
  augroup END
endif

" Don't keep viminfo for files in temp directories or shm
if has('viminfo')
  if has('autocmd')
    augroup viminfoskip
      autocmd!
      silent! autocmd BufRead,BufNewFilePre
        \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
        \ setlocal viminfo=
    augroup END
  endif
endif

" Enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif

" disable folding
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"        <> Text, Tab and Indent related <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" 1 tab === 2 spaces
set shiftwidth=4
set tabstop=4

" Number of spaces to use for each step of indent
set shiftwidth=4
set softtabstop=4 noexpandtab

" Use one space, not two, after punctuation
set nojoinspaces

" Don't automatically wrap text when typing
set fo-=t

" Set characters to show for trailing whitespace and
" end-of-line. Also supports tab, but I set expandtab
" and thus tabs are always turned into spaces
set listchars=tab:>>,trail:!,eol:$

" Support for numbered/bullet lists
set formatoptions+=n


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"              <> Status line <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line.
set laststatus=2

" Show current mode in the status line.
if exists("+showmode")
  set showmode
endif

" Show the (partial) command as it’s being typed.
if exists("+showcmd")
  set showcmd
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                <> Key Binds <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTREE
map <C-n> :NERDTreeToggle<CR>

" Find Definition
map <C-d> :ALEGoToDefinition<CR>
