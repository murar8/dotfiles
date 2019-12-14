""" Vim plug

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

""" Basic

" No vi compatibility
set nocompatible            
" Enable syntax highlighting
syntax on                   
" Enable filetype specific indentation
filetype plugin indent on
" <Space> as more reachable leader
let mapleader = " "        
" Abandoned buffers are hidden
set hidden
" Default file encoding
set encoding=utf-8

""" Visual

" Wrap long lines
set wrap
" Show line numbers
set number		  
" Don't show numbers in neovim terminal
au TermOpen * setlocal nonumber 
" Show file stats
set ruler               
" Break lines at word (requires Wrap lines)
set linebreak		    
" Wrap-broken line prefix
set showbreak=^^^
" Line wrap (number of cols)
set textwidth=120	    
" Highlight matching brace
set showmatch       
" Show incomplete cmds down the bottom
set showcmd             
" Show current mode down the bottom
set showmode            
" add vertical lines on columns
set colorcolumn=80,120  
" Use visual bell (no beeping)
set visualbell	        
" Cmdline visual completion menu
set wildmenu
" Don't complete some files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" Show the filename in the window title bar
set title                   
" Always display the status line
set laststatus=2
" Set the command window height to 2 lines
set cmdheight=2
" Don't go to start of line for certain movements
set nostartofline
" Keep some lines above/below cursor
set scrolloff=2
" Don't blink
set gcr=a:blinkon0
" Hide redundant mode indicator
set noshowmode
" Set more natural split direction
set splitbelow splitright
" Set abbreviated messages
set shortmess+=a
" Enable mouse usage
set mouse=a


""" Theme

set background=dark
set termguicolors
colorscheme gruvbox


""" Search

" Highlight all search results
set hlsearch	        
" Case-sensitive search if term contains uppercase letters
set ignorecase smartcase 
" Searches for strings incrementally
set incsearch	        
" Regex without escaping
set magic

""" Indentation

" Auto-indent new lines
set autoindent	        
" Use spaces instead of tabs
set expandtab	        
" Number of auto-indent spaces
set shiftwidth=4	    
" Enable smart-indent
set smartindent	        
" Enable smart-tabs
set smarttab	        
" Number of spaces added when hitting Tab
set softtabstop=4	    
" Number of spaces per Tab
set tabstop=4


""" Directories

" Undo history
set undodir=~/.vim/undodir
" Backup files
set backupdir=~/.vim/backup
" Swap files
set directory=~/.vim/swap


""" History

" Number of undo levels
set undolevels=1000	            
" Backspace over anything
set backspace=indent,eol,start	
" Maintain undo history between sessions
set undofile 
" Store lots of :cmdline history
set history=1000                


""" Performance

" Don't update the display while executing macros
set lazyredraw             
" Send more characters at a given time.
set ttyfast                 


""" Misc

" Reload files changed outside vim
set autoread                    
" Display a confirmation dialog when closing an unsaved file.
set confirm
" Set key sequence timeout
set timeout timeoutlen=250
" Always show completion menu
set completeopt=longest,menuone



""" Mappings

" Move by visual lines
nnoremap j gj
nnoremap k gk
" Fast exit from terminal insert mode
tnoremap <silent> <Esc> <C-\><C-n>

""" Autocmds
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
    au BufWritePost .vimrc source %
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au VimEnter * cd `=GetRootDir()`
    autocmd TermOpen * startinsert
augroup END


""" Plugins

" Gruvbox
let g:gruvbox_italic = 1

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" fzf.vim
" Using floating windows of Neovim to start fzf
let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
                \ 'row': (&lines - height) / 2,
                \ 'col': (&columns - width) / 2,
                \ 'width': width,
                \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Include hidden files (requires 'fd' installed)
let $FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"

" Preview window (needs 'bat' installed for syntax highlighting)
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>f :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fl :Lines<CR>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = "exceeding"

" vim-go
let g:go_gorename_command = 'gopls'
let g:go_metalinter_command = "golangci-lint run --exclude-use-default=false"
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
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_gopls_complete_unimported = 1

nmap <leader>gl <Plug>(go-metalinter) 
nmap <leader>gt <Plug>(go-test) 
nmap <leader>ge <Plug>(go-run-tab)
nmap <leader>gc <Plug>(go-coverage)
nmap <leader>gr <Plug>(go-rename)
nmap <leader>gb <Plug>(go-metalinter) 
nmap <leader>gd <Plug>(go-doc) 
nmap <leader>gv <Plug>(go-vet) 

augroup go
    au!
    " au BufWritePost *.go GoVet
augroup END
