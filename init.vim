let NVIM_CONFIG = '/Users/kwhittin/.config/nvim'
let INITIALIZERS = NVIM_CONFIG . '/initializers'

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'kien/ctrlp.vim'
Plug 'mkarmona/colorsbox'
Plug 'myusuf3/numbers.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'wellsjo/wellsokai.vim'
call plug#end()

let mapleader = "\<Space>"
set number

execute 'source ' INITIALIZERS . '/airline/init.vim'
execute 'source ' INITIALIZERS . '/colorscheme/init.vim'
execute 'source ' INITIALIZERS . '/ctrlp/init.vim'
execute 'source ' INITIALIZERS . '/ctrlp_cmdpalette/init.vim'
execute 'source ' INITIALIZERS . '/gitgutter/init.vim'
