""" Vim plug

" automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

call plug#end()

syntax on
filetype plugin indent on

" set spelllang=en,it   " Set spell check languages
" set spell             " Enable spell checking
"
" set foldenable        " Enable folding
" set foldlevel=3       " Fold only deeper in the tree
" set foldmethod=syntax " Folding based on syntax highlighting

set autoindent                     " Auto keep indentation
set autoread                       " Read file changes from outside
set background=dark                " Dark background
set backspace=indent,eol,start     " Cool backspace that works
set belloff=all                    " No bells
set breakindent                    " Wrapped lines continue to be indented
set clipboard=unnamed,unnamedplus  " Integrate with system clipboard
set cmdheight=3                    " Set the command window height
set completeopt=longest,menuone    " Always show completion menu
set confirm                        " Display a confirmation dialog when closing an unsaved file
set encoding=utf-8                 " Default file encoding
set expandtab                      " Use spaces instead of tabs
set gcr=a:blinkon0                 " Don't blink
set hidden                         " Abandoned buffers are hidden
set history=1000                   " Command history size
set hlsearch                       " Highlight searches
set incsearch                      " Search while you type
set laststatus=2                   " Show statusline always
set lazyredraw                     " Don't update the display while executing macros
set linebreak                      " Break lines at word (requires Wrap lines)
set magic                          " Regex without escaping
set mouse=a                        " Enable mouse usage
set mousehide                      " Hide mouse while typing
set nocompatible                   " No Vi emulation
set noshowmode                     " Redundant (shown with vim-airline)
set nostartofline                  " Don't go to start of line for page movements
set number                         " Show line numbers
set scrolloff=2                    " Keep some lines above/below cursor
set sessionoptions-=options,blanks " Discard useless session data
set shiftround                     " Indent to nearest multiple of shiftwidth
set shiftwidth=4                   " Number of auto-indent spaces
set shortmess+=aIc                 " Set abbreviated messages
set showbreak=^                    " Wrap-broken line prefix
set showmatch                      " Highlight matching brace
set signcolumn=yes                 " Always show signcolumn
set smartcase                      " Case-sensitive search if term contains uppercase letters
set smartindent                    " Enable smart-indent
set smarttab                       " Auto tab alignment
set softtabstop=4                  " Number of spaces added when hitting Tab
set splitbelow splitright          " Set more natural split direction
set tabstop=4                      " Number of spaces per Tab
set termguicolors                  " Enable 24bit TUI colors
set timeoutlen=250                 " Set key sequence timeout
set title                          " Show the filename in the window title bar
set ttimeoutlen=0                  " Don't wait for a single keycode to be inserted
set ttyfast                        " Better performance
set undofile                       " Maintain undo history between sessions
set undolevels=1000                " More undo history
set updatetime=250                 " Time to trigger CursorHold
set whichwrap=b,s,<,>,[,]          " Backspace and cursor keys wrap too
set wildmenu                       " Commandline completion
set wildmode=list:longest,full     " Complete longest common match, then full

" Don't complete some files
set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so

" Set the type of mouse codes vim will recognize  
if !has('nvim') | set ttymouse=sgr | endif
" Highlight current line
if has('nvim') | set cursorline | endif           

if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "", 0700)
endif

let dir=$HOME."/.vim/swap"
let undodir=$HOME."~/.vim/undo"

let mapleader = " " " <Space> is a more reachable leader

silent! colorscheme gruvbox " Set color scheme

""" Autocmds

" Returns either the git root or the directory of currently open file
function! GetRootDir()
    let path = expand('%:p:h')
    let git_path = system("git -C " . path . " rev-parse --show-toplevel")
    let is_file = filereadable(path . "/" . expand("%:t"))
    if !v:shell_error && is_file
        return git_path 
    else
        return path
    endif
endfunction

augroup cmds
    autocmd!
    " Source vimrc on write
    au BufWritePost init.vim,.vimrc source %
    " Return to last position in file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Set pwd to GetRootDir value
    au VimEnter * cd `=GetRootDir()`
    if has('nvim')
        " Don't show numbers in terminal
        autocmd TermOpen term://* setlocal nonumber
        " Start insert mode right away in terminal
        autocmd TermOpen term://* startinsert
    endif
augroup END

""" Mappings

" Move by visual lines
nnoremap j gj
nnoremap k gk
" Exit terminal insert mode with ESC
tnoremap <silent> <Esc> <C-\><C-n>
" Clear search highlighting
nmap <silent> ,/ :nohlsearch<CR>
" Buffers
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprev<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>bl :ls<CR>

nnoremap <leader>q @q

""" Plugins

" Gruvbox
let g:gruvbox_italic = 1

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ea <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ea <Plug>(EasyAlign)

" fzf.vim
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>ag :Ag<CR>

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeHighlightCursorline=1

nnoremap <leader>e :NERDTreeToggleVCS<CR>
