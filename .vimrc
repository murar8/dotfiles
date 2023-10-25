" Basic

syntax on
filetype plugin indent on

set nocompatible                   " Don't try to be vi compatible.
set ttyfast                        " Improves smoothness of redrawing.


" Behaviour

set autoread                       " Automatically re-read files if unmodified inside Vim.
set nohidden                       " Unload the current buffer when it is abandoned.
set confirm                        " Display a confirmation dialog when closing an unsaved file.
set encoding=utf-8                 " Use an encoding that supports unicode.
set backspace=indent,eol,start     " Allow backspacing over indentation, line breaks and insertion start.
set clipboard=unnamed,unnamedplus  " Use system clipboard.


" Appearance

set title                          " Set the window's title, reflecting the file currently being edited.
set number                         " Show line numbers on the sidebar.
set relativenumber                 " Show line number on the current line and relative numbers on all other lines.
set scrolloff=3                    " The number of screen lines to keep above and below the cursor.
set ruler                          " Always show cursor position.
set cursorline                     " Highlight the line currently under cursor.
set laststatus=2                   " Always display the status bar.
set lazyredraw                     " Don't update screen during macro and script execution.


" Indentation

set tabstop=4                      " Indent using four spaces.
set softtabstop=4                  " How many columns the cursor moves right when you press <Tab>. 
set shiftwidth=4                   " When shifting, indent using four spaces.
set expandtab                      " Convert tabs to spaces.
set smarttab                       " Insert tabstop number of spaces when the tab key is pressed.
set autoindent                     " New lines inherit the indentation of previous lines.
set smartindent                    " Intelligently indent new lines based on rules.
set shiftround                     " When shifting lines, round the indentation to the nearest multiple of shiftwidth.


" Search

set hlsearch                       " Enable search highlighting.
set incsearch                      " Incremental search that shows partial matches.
set smartcase                      " Automatically switch search to case-sensitive when search query contains an uppercase letter.
set showmatch                      " Live match highlighting.


" Wrapping

set linebreak                      " Avoid wrapping a line in the middle of a word.
set breakindent                    " Every wrapped line will continue visually indented.
set showbreak=^                    " String to put at the start of lines that have been wrapped.


" Mouse

set mouse=a                        " Enable mouse in all modes.
set mousehide                      " Hide the mouse pointer is hidden when characters are typed.

if !has('nvim') | set ttymouse=sgr | endif " Set the type of mouse codes vim will recognize.


" Completion

set wildmenu                       " Horizontal and unobtrusive little completion menu.
set wildmode=list:longest,full     " First tab will complete to longest string and show the the match list, second tab opens wildmenu.

set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so " Don't complete some files.


" Undo / Swap

if !isdirectory($HOME."/.vim")      | call mkdir($HOME."/.vim", "", 0700)      | endif
if !isdirectory($HOME."/.vim/undo") | call mkdir($HOME."/.vim/undo", "", 0700) | endif
if !isdirectory($HOME."/.vim/swap") | call mkdir($HOME."/.vim/swap", "", 0700) | endif

let dir=$HOME."/.vim/swap"         " Directory to store swap files.
let undodir=$HOME."~/.vim/undo"    " Directory to store undo history.

set undofile                       " Enable undo file.
set undolevels=1000                " Increase undo levels.
set history=1000                   " Increase the undo limit.


""" Autocmds

augroup cmds
    autocmd!
    " Source vimrc on write.
    au BufWritePost init.vim,.vimrc source %

    " Return to last position in file.
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END


""" Mappings

let mapleader = " " " <Space> is a more reachable leader.

nnoremap <leader>=  gg=G<C-o> " Format whole file.
nnoremap <CR>       :noh<CR><CR> " Clear search highlight on return.
