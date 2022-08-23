set termguicolors
" Leader
let mapleader=','

" Spellcheck
setlocal spell spelllang=en_us

" Tab/indentions
set expandtab
set shiftwidth=2
set tabstop=2

" Line Width Guideline
set colorcolumn=100

" Panes
set splitright
set splitbelow

" Maintain buffers when they're not visible
set hidden

" Opens the file explorer
map <silent> <C-\> :Explore<CR>

" Open the file fuzzy finder
map <silent> <S-t> :Files<CR>

" Open project-wide text fuzzy finder
map <silent> <S-f> :Ag<CR>

" Hide search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" Copy file name to clipboard
nmap cp :let @+ = expand("%:p")<cr>

" See https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jgdavey/vim-blockle'
Plug 'honza/vim-snippets'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 't9md/vim-choosewin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vivkin/flatland.vim'

call plug#end()

" vim-choosewin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 0

" fzf.vim
let g:fzf_preview_window = ['up:90%', 'ctrl-/']

" vim-numbertoggle
set number relativenumber

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
" straight buffer tabs, remove next 2 lines for angled tabs
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" default, jsformatter, unique_tail, or unique_tail_improved
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
"let g:airline_theme='solarized'
"let g:airline_theme='flatland'
" Light Theme
"let g:airline_theme='light'
" Dark Theme
let g:airline_theme='molokai'

" vim-ruby
" highlight Ruby operators
let g:ruby_operators = 1
let g:ruby_pseudo_operators = 1
" enable Ruby-specific folding
let g:ruby_fold = 1
" 1 or 0 (help ruby-hanging-element-indentation)
let g:ruby_indent_hanging_elements = 0
" spellcheck Ruby strings
let g:ruby_spellcheck_strings = 1

" flatland.vim
" colors molokai
let g:rehash256 = 1

" Javascipt Libraries Syntax
let g:used_javascript_libs = 'underscore,vue'
autocmd BufNewFile,BufRead *.vue set syntax=javascript

" Custom Commands
command! ReloadInitSource source $MYVIMRC

" Light theme
"color basic-light

" Dark Theme
color vividchalk

" Use ruby syntax highlighting for new buffers
set syntax=ruby

set foldlevelstart=4
" Customized version of folded text, idea by
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText(string) "{{{1
    "get first non-blank line
    let fs = v:foldstart
    if getline(fs) =~ '^\s*$'
      let fs = nextnonblank(fs + 1)
    endif
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let pat  = matchstr(&l:cms, '^\V\.\{-}\ze%s\m')
    " remove leading comments from line
    let line = substitute(line, '^\s*'.pat.'\s*', '', '')
    " remove foldmarker from line
    let pat  = '\%('. pat. '\)\?\s*'. split(&l:fmr, ',')[0]. '\s*\d\+'
    let line = substitute(line, pat, '', '')

"   let line = substitute(line, matchstr(&l:cms,
"	    \ '^.\{-}\ze%s').'\?\s*'. split(&l:fmr,',')[0].'\s*\d\+', '', '')

    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    "let foldLevelStr = '+'. v:folddashes
    let foldLevelStr = " " . " "
    let lineCount = line("$")
    if has("float")
      let foldPercentage = printf("[of %d lines] ", lineCount)
    endif
    if exists("*strwdith")
	let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    else
	"let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
	let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, " ", 'x', 'g')))
    endif
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set foldtext=CustomFoldText('\ ')
