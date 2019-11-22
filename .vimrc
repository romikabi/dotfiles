call plug#begin('~/.vim/plugged')

Plug 'https://github.com/keith/swift.vim'
Plug 'https://github.com/neovimhaskell/haskell-vim'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
