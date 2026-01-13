set termguicolors
" Leader
let mapleader=' '

" Performance optimizations
set lazyredraw          " Don't redraw screen during macros/scripts
set ttyfast             " Faster terminal connection
set updatetime=250      " Reduce CursorHold delay (default is 4000ms)
set timeoutlen=500      " Faster key sequence timeout
set ttimeoutlen=10      " Faster key code timeout
set regexpengine=1      " Use older but faster regex engine
set synmaxcol=200       " Limit syntax highlighting to first 200 columns
set maxmempattern=1000  " Limit memory for pattern matching

filetype plugin indent on

" Spellcheck - disabled by default for performance
" Enable with :setlocal spell spelllang=en_us
" setlocal spell spelllang=en_us

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

" Hide search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" Copy file name to clipboard
nmap cp :let @+ = expand("%")<cr>

" vim-choosewin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 0

" vim-numbertoggle
set number relativenumber

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" vim-ruby
" highlight Ruby operators
let g:ruby_operators = 1
let g:ruby_pseudo_operators = 1
" disable Ruby-specific folding for performance
let g:ruby_fold = 0
" 1 or 0 (help ruby-hanging-element-indentation)
let g:ruby_indent_hanging_elements = 0
" spellcheck Ruby strings
let g:ruby_spellcheck_strings = 1

let g:rehash256 = 1

" Javascipt Libraries Syntax
let g:used_javascript_libs = 'underscore,vue'
autocmd BufNewFile,BufRead *.vue set filetype=javascript

" Custom Commands
command! Rb set filetype=ruby
command! ReloadInitSource source $MYVIMRC | luafile ~/.config/nvim/lua/init.lua
command! StripShellColorCodes %s/\e\[\d\+m//g

set foldlevelstart=12
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

" load config files in Lua
lua require('init')
