"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   <> GENERAL <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make Vim more useful
set nocompatible

" Disable filetype detection
filetype off

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

" Try to detect file formats
set fileformats=unix,dos,mac

" Disable unsafe commands
set secure

" Show the filename in the window titlebar
if exists("+title")
	set title
endif

"Return to last edit position when opening files
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

" Tsuquyomi
let g:tsuquyomi_use_local_typescript = 0
let g:tsuquyomi_use_dev_node_module = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  <> Interface <>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Completetion (text) settings
set completeopt=longest,menuone

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

" Windows size at startup
set lines=50 columns=200

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

" Tab indentation
set noexpandtab
set shiftwidth=4
set tabstop=4

" Use one space, not two, after punctuation
set nojoinspaces

" Don't automatically wrap text when typing
set fo-=t

" Enable list
set list

" Set characters to show for trailing whitespace and
" end-of-line. Also supports tab, but I set expandtab
" and thus tabs are always turned into spaces
set listchars=eol:§,tab:¤›,extends:»,precedes:«,nbsp:‡

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
