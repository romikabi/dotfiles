" install vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/keith/swift.vim'
Plug 'https://github.com/neovimhaskell/haskell-vim'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rkitover/vimpager', { 'do': 'make install' }

call plug#end()

syntax on
filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set nocompatible
set nu
set hidden
set ttimeoutlen=10
set guicursor=

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let @l = 'jV/]k:sort'
let @s = ':g/swift_sources/normal @l' 
