" Basic

syntax on
filetype plugin indent on

set nocompatible " Don't try to be vi compatible.
set ttyfast      " Improves smoothness of redrawing.


" Behaviour

set autoread                      " Automatically re-read files if unmodified inside Vim.
set backspace=indent,eol,start    " Allow backspacing over indentation, line breaks and insertion start.
set clipboard=unnamed,unnamedplus " Use system clipboard.
set confirm                       " Display a confirmation dialog when closing an unsaved file.
set encoding=utf-8                " Use an encoding that supports unicode.
set magic                         " Regex without escape.
set matchpairs+=<:>               " Use % to jump from < to >.
set hidden                        " Allow editing other files witout writing the current buffer.


" Appearance

set cursorline     " Highlight the line currently under cursor.
set laststatus=2   " Always display the status bar.
set lazyredraw     " Don't update screen during macro and script execution.
set number         " Show line numbers on the sidebar.
set relativenumber " Show line number on the current line and relative numbers on all other lines.
set ruler          " Always show cursor position.
set scrolloff=3    " The number of screen lines to keep above and below the cursor.
set title          " Set the window's title, reflecting the file currently being edited.


" Indentation

set autoindent    " New lines inherit the indentation of previous lines.
set expandtab     " Convert tabs to spaces.
set shiftround    " When shifting lines, round the indentation to the nearest multiple of shiftwidth.
set shiftwidth=4  " When shifting, indent using four spaces.
set smartindent   " Intelligently indent new lines based on rules.
set smarttab      " Insert tabstop number of spaces when the tab key is pressed.
set softtabstop=4 " How many columns the cursor moves right when you press <Tab>.
set tabstop=4     " Indent using four spaces.


" Search

set gdefault   " Global search by default.
set hlsearch   " Enable search highlighting.
set ignorecase " Ignore search casing.
set incsearch  " Incremental search that shows partial matches.
set showmatch  " Live match highlighting.
set smartcase  " Automatically switch search to case-sensitive when search query contains an uppercase letter.


" Wrapping

set breakindent " Every wrapped line will continue visually indented.
set linebreak   " Avoid wrapping a line in the middle of a word.
set showbreak=^ " String to put at the start of lines that have been wrapped.


" Mouse

set mouse=a   " Enable mouse in all modes.
set mousehide " Hide the mouse pointer is hidden when characters are typed.


" Completion

set wildmenu                   " Horizontal and unobtrusive little completion menu.
set wildmode=list:longest,full " First tab will complete to longest string and show the the match list, second tab opens wildmenu.

set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so " Don't complete some files.


" History

if !isdirectory($HOME."/.vim")      | call mkdir($HOME."/.vim", "", 0700)      | endif
if !isdirectory($HOME."/.vim/undo") | call mkdir($HOME."/.vim/undo", "", 0700) | endif
if !isdirectory($HOME."/.vim/swap") | call mkdir($HOME."/.vim/swap", "", 0700) | endif

let dir="~/.vim/swap"     " Directory to store swap files.
let undodir="~/.vim/undo" " Directory to store undo history.

set history=1000    " Increase the undo limit.
set undofile        " Enable undo file.
set undolevels=1000 " Increase undo levels.


""" Mappings

let mapleader = " " " <Space> is a more reachable leader.

" Clear search highlight on return.
nnoremap <CR> :noh<CR><CR>
" Format whole file.
nnoremap <silent><leader>= :set paste<CR>m`gg=G``:set nopaste<CR>
" Insert a new line below without leaving normal mode.
nnoremap <silent><leader>o :set paste<CR>m`o<Esc>``h:set nopaste<CR>
" Insert a new line above without leaving normal mode.
nnoremap <silent><leader>O :set paste<CR>m`O<Esc>``h:set nopaste<CR>


""" Autocmds

augroup vimrc
	autocmd!
	" Source vimrc on write.
	au BufWritePost init.vim,.vimrc source %
augroup END

augroup restorepos
	autocmd!
	" Return to last position in file.
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

