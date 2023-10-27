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
				\| PlugInstall --sync | source ~/.vim/plugin/plug.vim
				\| endif
augroup end


call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align', { 'tag': '2.10.0' }
Plug 'mg979/vim-visual-multi',  { 'commit': 'aec289a' }
Plug 'tpope/vim-commentary',    { 'tag': 'v1.3' }
Plug 'tpope/vim-sensible',      { 'tag': 'v2.0' }
Plug 'tpope/vim-surround',      { 'tag': 'v2.2' }
Plug 'airblade/vim-gitgutter',  { 'commit': 'f7b9766' }
Plug 'morhetz/gruvbox',         { 'commit': 'f1ecde8' }
Plug 'vim-airline/vim-airline', { 'tag': 'v0.11' }

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

