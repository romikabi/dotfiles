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
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'terryma/vim-smooth-scroll'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'PeterRincker/vim-searchlight'
Plug 'andymass/vim-matchup'

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

" persistent undo
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p", 0700)
endif
set undofile
set undodir=$HOME/.vim/undodir

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
map <C-n> :NERDTreeToggle<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" scroll settings (lines, milliseconds per frame, lines per frame)
noremap <silent> <c-u> :call smooth_scroll#up(10, 10, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(10, 10, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 3)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 3)<CR>

let g:signify_sign_add    = '┃'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'
let g:signify_sign_show_count = 0
