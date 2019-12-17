""" Vim plug

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'


call plug#end()

syntax on
filetype plugin indent on


set autoindent                       " Auto keep indentation
set autoread                         " Read file changes from outside
set background=dark                  " Dark background
set backspace=indent,eol,start       " Cool backspace that works
set belloff=all                      " No bells
set clipboard=unnamed,unnamedplus    " Integrate with system clipboard
set cmdheight=3                      " Set the command window height
set colorcolumn=79,119               " Add vertical lines on columns
set completeopt=longest,menuone      " Always show completion menu
set confirm                          " Display a confirmation dialog when closing an unsaved file
set encoding=utf-8                   " Default file encoding
set expandtab                        " Use spaces instead of tabs
set foldenable                       " Enable folding
set foldlevel=3                      " Fold only deeper in the tree
set foldmethod=syntax                " Folding based on syntax highlighting
set formatoptions=tcqj               " How to format text
set gcr=a:blinkon0                   " Don't blink
set hidden                           " Abandoned buffers are hidden
set history=10000                    " Command history size
set hlsearch                         " Highlight searches
set incsearch                        " Search while you type
set langnoremap                      " Don't apply langmap to mappings
set laststatus=2                     " Show statusline always
set lazyredraw                       " Don't update the display while executing macros
set linebreak                        " Break lines at word (requires Wrap lines)
set listchars=tab:>\ ,trail:-,nbsp:+ " Blank characters to show
set magic                            " Regex without escaping
set mouse=a                          " Enable mouse usage
set mousehide                        " Hide mouse while typing
set nocompatible                     " No Vi emulation
set noshowmode                       " Redundant (shown in vim-airline)
set nostartofline                    " Don't go to start of line for page movements
set number                           " Show line numbers
set scrolloff=2                      " Keep some lines above/below cursor
set sessionoptions-=options,blanks   " Discard useless session data
set shiftwidth=4                     " Number of auto-indent spaces
set shortmess+=aIc                   " Set abbreviated messages
set showbreak=^                      " Wrap-broken line prefix
set showmatch                        " Highlight matching brace
set smartcase                        " Case-sensitive search if term contains uppercase letters
set smartindent                      " Enable smart-indent
set smarttab                         " Auto tab alignment
set softtabstop=4                    " Number of spaces added when hitting Tab
set splitbelow splitright            " Set more natural split direction
set tabstop=4                        " Number of spaces per Tab
set termguicolors                    " Enable 24bit TUI colors
set timeoutlen=250                   " Set key sequence timeout
set title                            " Show the filename in the window title bar
set ttyfast                          " Better performance
set undofile                         " Maintain undo history between sessions
set updatetime=250                   " Time to trigger CursorHold
set whichwrap=b,s,<,>,[,]            " Backspace and cursor keys wrap too
set wildmenu                         " Commandline completion
set wildmode=list:longest,full       " Complete longest common match, then full

" Don't complete some files
set wildignore+=*.o,*~,*.pyc,*.swp,*.*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tmp/*,*.so

" Highlight current line
if has('nvim') | set cursorline | endif           

let dir='~/.vim/swap'
let undodir='~/.vim/undo'

let mapleader = " " " <Space> is a more reachable leader

colorscheme gruvbox " Set color scheme

""" Functions

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


""" Mappings

" Move by visual lines
nnoremap j gj
nnoremap k gk
" Exit terminal insert mode with ESC
tnoremap <silent> <Esc> <C-\><C-n>
" Clear search highlighting
nmap <silent> ,/ :nohlsearch<CR>
" Buffers
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprev<CR>
nnoremap <silent> <leader>d :bdelete<CR>
nnoremap <silent> <leader>l :ls<CR>
:nnoremap <leader>q @q

""" Autocmds

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

""" Plugins

" Gruvbox
let g:gruvbox_italic = 1

" vim-airline
let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ea <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ea <Plug>(EasyAlign)

" ctrlp
let g:ctrlp_map="<leader>f"

" vim-go
let g:go_rename_command = 'gopls'
let g:go_metalinter_command = "golangci-lint run --exclude-use-default=false"
let g:go_fmt_command = "goimports"
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
"let g:go_highlight_diagnostic_errors = 1
"let g:go_highlight_diagnostic_warnings = 1
let g:go_auto_type_info = 0
" let g:go_doc_popup_window = 1
" let g:go_gopls_complete_unimported = 1
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_term_enabled = 1

nmap <leader>gl <Plug>(go-metalinter) 
nmap <leader>gt <Plug>(go-test) 
nmap <leader>ge <Plug>(go-run-vertical)
nmap <leader>gc <Plug>(go-coverage)
nmap <leader>gr <Plug>(go-rename)
nmap <leader>gd <Plug>(go-doc-vertical) 
nmap <leader>gv <Plug>(go-vet) 

nnoremap <leader>ds :GoDebugStart<CR>
nnoremap <leader>dr :GoDebugRestart<CR>
nnoremap <leader>dk :GoDebugStop<CR>
nnoremap <leader>db :GoDebugBreakpoint<CR>
nnoremap <leader>dt :GoDebugTest<CR>

" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'go': ['gopls']}
let g:ale_fixers = {'go': ['goimports']}
let g:ale_completion_enabled = 1
let g:ale_close_preview_on_insert = 1
let g:ale_fix_on_save = 1  
let g:ale_sign_highlight_linenrs = 1
let g:ale_virtualtext_cursor = 1

" imap <C-Space> <Plug>(ale_complete)

nmap <leader>au <Plug>(ale_find_references)
nmap <leader>af <Plug>(ale_fix)
nmap <leader>ad <Plug>(ale_go_to_definition_in_vsplit) 
nmap <leader>at <Plug>(ale_go_to_type_definition_in_vsplit)
nmap <leader>ai <Plug>(ale_detail)
nmap <leader>h <Plug>(ale_hover)
nmap <leader>[ <Plug>(ale_previous_wrap) 
nmap <leader>] <Plug>(ale_next_wrap) 

augroup ale
    au!
augroup END
