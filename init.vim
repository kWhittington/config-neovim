let NVIM_CONFIG = '/Users/kwhittin/.config/nvim'
let INITIALIZERS = NVIM_CONFIG . '/initializers'

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'kien/ctrlp.vim'
Plug 'mkarmona/colorsbox'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'wellsjo/wellsokai.vim'
call plug#end()

let mapleader = "\<Space>"

execute 'source ' INITIALIZERS . '/airline/init.vim'
execute 'source ' INITIALIZERS . '/colorscheme/init.vim'
execute 'source ' INITIALIZERS . '/ctrlp_cmdpalette/init.vim'
