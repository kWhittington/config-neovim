let NVIM_CONFIG = '/Users/kwhittin/.config/nvim'
let INITIALIZERS = NVIM_CONFIG . '/initializers'

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'mkarmona/colorsbox'
Plug 'tomasr/molokai'
Plug 'wellsjo/wellsokai.vim'
call plug#end()

execute 'source ' INITIALIZERS . '/airline/init.vim'
