" Install vim-plug if not found.
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/0.11.0/plug.vim
endif


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
set hidden                        " Allow editing other files witout writing the current buffer.
set magic                         " Regex without escape.
set matchpairs+=<:>               " Use % to jump from < to >.
set timeoutlen=400                " Time in milliseconds to wait for a mapped sequence to complete.

set splitbelow " Open new windows below the current window.
set splitright " Open new windows right of the current window.

" Appearance

set cursorline           " Highlight the line currently under cursor.
set cursorlineopt=number " Show cursor position on the sidebar.

set laststatus=2 " Always display the status bar.
set number       " Show line numbers on the sidebar.
set ruler        " Always show cursor position.
set scrolloff=5  " The number of screen lines to keep above and below the cursor.
set title        " Set the window's title, reflecting the file currently being edited.


" Indentation

set autoindent " New lines inherit the indentation of previous lines.
set expandtab  " Convert tabs to spaces.
set shiftround " When shifting lines, round the indentation to the nearest multiple of shiftwidth.
set smarttab   " Insert tabstop number of spaces when the tab key is pressed.

set shiftwidth=4  " For indenting lines.
set softtabstop=4 " When you press the Tab key.
set tabstop=4     " Visual length of a tab character \t.


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
set showbreak=↪ " String to put at the start of lines that have been wrapped.


" Mouse

set mouse=a   " Enable mouse in all modes.
set mousehide " Hide the mouse pointer is hidden when characters are typed.


" Completion

set wildmenu                   " Horizontal and unobtrusive little completion menu.
set wildmode=list:longest,full " First tab will complete to longest string and show the the match list, second tab opens wildmenu.
set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so " Don't complete some files.


" History

" Swap and undo file format is incompatible between Vim versions so we keep them separate.
let $dir = $HOME."/.vim/swap/".v:version
let $undodir = $HOME."/.vim/undo/".v:version

if !isdirectory($dir) | call mkdir($dir, "p") | endif
if !isdirectory($undodir) | call mkdir($undodir, "p") | endif

set dir=$dir         " Directory to store swap files.
set history=1000     " Increase the undo limit.
set undodir=$undodir " Directory to store undo history.
set undofile         " Enable undo file.
set undolevels=1000  " Increase undo levels.


""" Mappings

let mapleader = " "         " <Space> is a more reachable leader.
nnoremap <ESC> :noh<CR><CR> " Clear search highlight on return.

""" Autocmds

augroup vimrc
    autocmd!
    " Source vimrc on write.
    au BufWritePost .vimrc source %
augroup END

augroup restorepos
    autocmd!
    " Return to last position in file.
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END


" Plugins

augroup plug
    autocmd!
    " Run PlugInstall if there are missing plugins.
    " https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
augroup end

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-rooter'
Plug 'github/copilot.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'

call plug#end()

" junegunn/vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga).
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip).
nmap ga <Plug>(EasyAlign)

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

" github/copilot.vim

highlight CopilotSuggestion guifg=#665C54

" machakann/vim-highlightedyank

let g:highlightedyank_highlight_duration = 200
let g:highlightedyank_highlight_in_visual = 0
