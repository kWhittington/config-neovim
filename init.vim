set termguicolors
" Leader
let mapleader=','

" Tab/indentions
set expandtab
set shiftwidth=2
set tabstop=2

" Line Width Guideline
set colorcolumn=100

" Panes
set splitright
set splitbelow

" Ignore case when searching
set ignorecase

map <silent> <C-\> :Explore<cr>

" Hide search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" See https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ohree/javascript-libraries-syntax.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vivkin/flatland.vim'
call plug#end()

" vim-numbertoggle
set number relativenumber

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
"let g:airline_theme='solarized'
"let g:airline_theme='flatland'
let g:airline_theme='molokai'

" flatland.vim
colors molokai
let g:rehash256 = 1

" Javascipt Libraries Syntax
let g:used_javascript_libs = 'underscore,vue'
autocmd BufNewFile,BufRead *.vue set syntax=javascript
