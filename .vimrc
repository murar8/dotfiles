" Plug

" Install vim-plug if not found.
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/0.11.0/plug.vim
endif

augroup plug
    autocmd!
    " Run PlugInstall if there are missing plugins.
    " https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
augroup end

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align', { 'tag': '2.10.0' }
Plug 'mg979/vim-visual-multi',  { 'commit': 'aec289a' }
Plug 'tpope/vim-commentary',    { 'tag': 'v1.3' }
Plug 'tpope/vim-sensible',      { 'tag': 'v2.0' }
Plug 'tpope/vim-surround',      { 'tag': 'v2.2' }

" Some plugin are not necessary when running inside vscode-neovim.
if !exists('g:vscode')
    Plug 'airblade/vim-gitgutter',         { 'commit': 'f7b9766' }
    Plug 'morhetz/gruvbox',                { 'commit': 'f1ecde8' }
    Plug 'vim-airline/vim-airline',        { 'tag': 'v0.11' }
endif

call plug#end()

" junegunn/vim-easy-align

xmap ga <Plug>(EasyAlign)| " Start interactive EasyAlign in visual mode (e.g. vipga).
nmap ga <Plug>(EasyAlign)| " Start interactive EasyAlign for a motion/text object (e.g. gaip).

" vim-airline/vim-airline

let g:airline#extensions#tabline#enabled = 1
let g:airline_highlighting_cache = 0 " Caches the changes to the highlighting groups.
let g:airline_symbols_ascii = 1

" morhetz/gruvbox

let g:gruvbox_italic=1
set termguicolors
set background=dark
silent! colorscheme gruvbox
silent! let g:airline_theme = "gruvbox"

" mg979/vim-visual-multi

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-k>' " Clashes with vscode keybindings.
let g:VM_maps['Find Subword Under'] = '<C-k>' " Clashes with vscode keybindings.


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
set nohidden                      " Unload the current buffer when it is abandoned.


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

set gdefault  " Global search by default.
set hlsearch  " Enable search highlighting.
set incsearch " Incremental search that shows partial matches.
set showmatch " Live match highlighting.
set smartcase " Automatically switch search to case-sensitive when search query contains an uppercase letter.


" Wrapping

set breakindent " Every wrapped line will continue visually indented.
set linebreak   " Avoid wrapping a line in the middle of a word.
set showbreak=^ " String to put at the start of lines that have been wrapped.


" Mouse

set mouse=a   " Enable mouse in all modes.
set mousehide " Hide the mouse pointer is hidden when characters are typed.

if !has('nvim') | set ttymouse=sgr | endif " Set the type of mouse codes vim will recognize.


" Completion

set wildmenu                   " Horizontal and unobtrusive little completion menu.
set wildmode=list:longest,full " First tab will complete to longest string and show the the match list, second tab opens wildmenu.

set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so " Don't complete some files.


" Undo / Swap

if !isdirectory($HOME."/.vim")      | call mkdir($HOME."/.vim", "", 0700)      | endif
if !isdirectory($HOME."/.vim/undo") | call mkdir($HOME."/.vim/undo", "", 0700) | endif
if !isdirectory($HOME."/.vim/swap") | call mkdir($HOME."/.vim/swap", "", 0700) | endif

let dir=$HOME."/.vim/swap"      " Directory to store swap files.
let undodir=$HOME."~/.vim/undo" " Directory to store undo history.

set history=1000    " Increase the undo limit.
set undofile        " Enable undo file.
set undolevels=1000 " Increase undo levels.


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


""" Mappings

let mapleader = " " " <Space> is a more reachable leader.

nnoremap <leader>=  gg=G<C-o>       " Format whole file.
nnoremap <CR>       :noh<CR><CR>    " Clear search highlight on return.

nnoremap <silent><leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR> " Insert a new line below without leaving normal mode.
nnoremap <silent><leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR> " Insert a new line above without leaving normal mode.

