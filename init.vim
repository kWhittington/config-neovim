s
" Leader
let mapleader=' '

filetype plugin indent on

" Neovim host config
" we're only using python
let g:python3_host_prog = expand('~/.pyenv/versions/pynvim/bin/python')
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

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

" Open the ctags fuzzy finder
map <Leader><t> :Telescope tags
map <silent> <Leader><S-t> :Telescope tags<CR>

" Open the file fuzzy finder
map <Leader><f> :Telescope find_files
map <silent> <Leader><S-f> :Telescope find_files<CR>

" Open project-wide text fuzzy finder
map <Leader><p> :Telescope live_grep
map <silent> <Leader><S-p> :Telescope live_grep<CR>

" Open buffers-wide text fuzzy finder
map <Leader><b> :Telescope buffers
map <silent> <Leader><S-b> :Telescope buffers<CR>

" Hide search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" Copy file name to clipboard
nmap cp :let @+ = expand("%")<cr>

" See https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'dundargoc/fakedonalds.nvim'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jgdavey/vim-blockle'
Plug 'hdima/python-syntax'
Plug 'honza/vim-snippets'
Plug 'jeetsukumaran/vim-python-indent-black'
Plug 'mg979/vim-visual-multi'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'numirias/semshi'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'tmhedberg/simpylfold'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 't9md/vim-choosewin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vivkin/flatland.vim'

call plug#end()

" nerdcommenter
let g:NERDAltDelims_bash = 1
let g:NERDAltDelims_javascript = 1
let g:NERDAltDelims_python = 1
let g:NERDAltDelims_ruby = 1
let g:NERDAltDelims_sh = 1

" vim-choosewin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 0

" fzf.vim
"let g:fzf_preview_window = ['up:80%', 'ctrl-/']

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
"let g:airline_solarized_bg='dark'
"let g:airline_theme='solarized'
"let g:airline_theme='flatland'
" Default to dark theme
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
autocmd BufNewFile,BufRead *.vue set filetype=javascript

" Custom Commands
command! Rb set filetype=ruby
command! ReloadInitSource source $MYVIMRC
command! StripShellColorCodes %s/\e\[\d\+m//g
" Light theme
command! LightTheme color basic-light | let g:airline_theme='light'
" Dark Theme
command! DarkTheme color vividchalk | let g:airline_theme='molokai'
DarkTheme

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

" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   F8                next scheme
"   Shift-F8          previous scheme
"   Alt-F8            random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColors all              (all $VIMRUNTIME/colors/*.vim)
"   :SetColors my               (names built into script)
"   :SetColors blue slate ron   (these schemes)
"   :SetColors                  (display current scheme names)
" Set the current color scheme based on time of day:
"   :SetColors now
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1
let s:mycolors = ['0x7A69_dark', '1989', '256-grayvim', '256-jungle', '256_noir', '3dglasses', 'Atelier_CaveDark', 'Atelier_CaveLight', 'Atelier_DuneDark', 'Atelier_DuneLight', 'Atelier_EstuaryDark', 'Atelier_EstuaryLight', 'Atelier_ForestDark', 'Atelier_ForestLight', 'Atelier_HeathDark', 'Atelier_HeathLight', 'Atelier_LakesideDark', 'Atelier_LakesideLight', 'Atelier_PlateauDark', 'Atelier_PlateauLight', 'Atelier_SavannaDark', 'Atelier_SavannaLight', 'Atelier_SeasideDark', 'Atelier_SeasideLight', 'Atelier_SulphurpoolDark', 'Atelier_SulphurpoolLight', 'Benokai', 'Black', 'BlackSea', 'Blue2', 'C64', 'CandyPaper', 'Chasing_Logic', 'ChocolateLiquor', 'ChocolatePapaya', 'CodeFactoryv3', 'Dark', 'Dark2', 'DarkDefault', 'DevC++', 'Dev_Delight', 'Dim', 'Dim2', 'DimBlue', 'DimGreen', 'DimGreens', 'DimGrey', 'DimRed', 'DimSlate', 'Green', 'Light', 'LightDefault', 'LightDefaultGrey', 'LightTan', 'LightYellow', 'Monokai', 'MountainDew', 'OceanicNext', 'OceanicNextLight', 'PapayaWhip', 'PaperColor', 'PerfectDark', 'Red', 'Revolution', 'SerialExperimentsLain', 'Slate', 'SlateDark', 'Spink', 'SweetCandy', 'Tomorrow-Night-Blue', 'Tomorrow-Night-Bright', 'Tomorrow-Night-Eighties', 'Tomorrow-Night', 'Tomorrow', 'VIvid', 'White2', 'abbott', 'abra', 'abyss', 'adam', 'adaryn', 'adobe', 'adrian', 'advantage', 'adventurous', 'af', 'afterglow', 'aiseered', 'alduin', 'ancient', 'anderson', 'angr', 'anotherdark', 'ansi_blows', 'antares', 'apprentice', 'aqua', 'aquamarine', 'arcadia', 'archery', 'argonaut', 'ashen', 'asmanian2', 'asmanian_blood', 'asmdev', 'asmdev2', 'astronaut', 'asu1dark', 'atom', 'aurora', 'automation', 'autumn', 'autumnleaf', 'ayu', 'babymate256', 'badwolf', 'bandit', 'base', 'base16-ateliercave', 'base16-atelierdune', 'base16-atelierestuary', 'base16-atelierforest', 'base16-atelierheath', 'base16-atelierlakeside', 'base16-atelierplateau', 'base16-ateliersavanna', 'base16-atelierseaside', 'base16-ateliersulphurpool', 'base16-railscasts', 'basic-dark', 'basic-light', 'basic', 'bayQua', 'baycomb', 'bclear', 'beachcomber', 'beauty256', 'beekai', 'behelit', 'benlight', 'bensday', 'billw', 'biogoo', 'birds-of-paradise', 'bitterjug', 'black_angus', 'blackbeauty', 'blackboard', 'blackdust', 'blacklight', 'blaquemagick', 'blazer', 'blink', 'blue', 'bluechia', 'bluedrake', 'bluegreen', 'bluenes', 'blueprint', 'blues', 'blueshift', 'bluez', 'blugrine', 'bluish', 'bmichaelsen', 'boa', 'bocau', 'bog', 'boltzmann', 'borland', 'breeze', 'breezy', 'brighton', 'briofita', 'broduo', 'brogrammer', 'brookstream', 'brown', 'bubblegum-256-dark', 'bubblegum-256-light', 'bubblegum', 'buddy', 'burnttoast256', 'busierbee', 'busybee', 'buttercream', 'bvemu', 'bw', 'c', 'c16gui', 'cabin', 'cake', 'cake16', 'calmar256-dark', 'calmar256-light', 'camo', 'campfire', 'candy', 'candycode', 'candyman', 'caramel', 'carrot', 'carvedwood', 'carvedwoodcool', 'cascadia', 'celtics_away', 'cgpro', 'chalkboard', 'chance-of-storm', 'charged-256', 'charon', 'chela_light', 'cherryblossom', 'chlordane', 'chocolate', 'chroma', 'chrysoprase', 'clarity', 'cleanphp', 'cleanroom', 'clearance', 'cloudy', 'clue', 'cobalt', 'cobalt2', 'cobaltish', 'coda', 'codeblocks_dark', 'codeburn', 'codedark', 'codeschool', 'coffee', 'coldgreen', 'colorer', 'colorful', 'colorful256', 'colorsbox-faff', 'colorsbox-greenish', 'colorsbox-material', 'colorsbox-stblue', 'colorsbox-stbright', 'colorsbox-steighties', 'colorsbox-stnight', 'colorzone', 'contrastneed', 'contrasty', 'cool', 'corn', 'corporation', 'crayon', 'crt', 'crunchbang', 'cthulhian', 'custom', 'cyberpunk', 'd8g_01', 'd8g_02', 'd8g_03', 'd8g_04', 'dante', 'dark-ruby', 'darkZ', 'darkblack', 'darkblue', 'darkblue2', 'darkbone', 'darkburn', 'darkdevel', 'darkdot', 'darkeclipse', 'darker-robin', 'darkerdesert', 'darkglass', 'darkocean', 'darkrobot', 'darkslategray', 'darkspectrum', 'darktango', 'darkzen', 'darth', 'dawn', 'deep-space', 'deepsea', 'default', 'delek', 'delphi', 'denim', 'derefined', 'desert', 'desert256', 'desert256v2', 'desertEx', 'desertedocean', 'desertedoceanburnt', 'desertink', 'despacio', 'detailed', 'deus', 'devbox-dark-256', 'deveiate', 'developer', 'diokai', 'disciple', 'distill', 'distinguished', 'django', 'donbass', 'donttouchme', 'doorhinge', 'doriath', 'dracula', 'dracula_bold', 'dual', 'dull', 'duotone-dark', 'duotone-darkcave', 'duotone-darkdesert', 'duotone-darkearth', 'duotone-darkforest', 'duotone-darkheath', 'duotone-darklake', 'duotone-darkmeadow', 'duotone-darkpark', 'duotone-darkpool', 'duotone-darksea', 'duotone-darkspace', 'dusk', 'dw_blue', 'dw_cyan', 'dw_green', 'dw_orange', 'dw_purple', 'dw_red', 'dw_yellow', 'dzo', 'earendel', 'earth', 'earthburn', 'eclipse', 'eclm_wombat', 'ecostation', 'editplus', 'edo_sea', 'ego', 'eink', 'ekinivim', 'ekvoli', 'elda', 'eldar', 'elflord', 'elise', 'elisex', 'elrodeo', 'elrond', 'emacs', 'enigma', 'enzyme', 'erez', 'eva', 'eva01-LCL', 'eva01', 'evening', 'evening1', 'evokai', 'evolution', 'fahrenheit', 'fairyfloss', 'falcon', 'far', 'felipec', 'feral', 'fight-in-the-shade', 'fine_blue', 'firewatch', 'flatcolor', 'flatland', 'flatlandia', 'flattened_dark', 'flattened_light', 'flattown', 'flattr', 'flatui', 'fnaqevan', 'fog', 'fokus', 'forneus', 'foursee', 'freya', 'frood', 'frozen', 'fruidle', 'fruit', 'fruity', 'fu', 'fx', 'garden', 'gardener', 'gemcolors', 'genericdc-light', 'genericdc', 'gentooish', 'getafe', 'getfresh', 'ghostbuster', 'github', 'gobo', 'golded', 'golden', 'goldenrod', 'goodwolf', 'google', 'gor', 'gotham', 'gotham256', 'gothic', 'grape', 'gravity', 'grayorange', 'graywh', 'grb256', 'greens', 'greenvision', 'greenwint', 'grey2', 'greyblue', 'greygull', 'grishin', 'gruvbox', 'gryffin', 'guardian', 'guepardo', 'h80', 'habiLight', 'happy_hacking', 'harlequin', 'heliotrope', 'hemisu', 'herald', 'heroku-terminal', 'heroku', 'herokudoc-gvim', 'herokudoc', 'hhazure', 'hhdblue', 'hhdcyan', 'hhdgray', 'hhdgreen', 'hhdmagenta', 'hhdred', 'hhdyellow', 'hhorange', 'hhpink', 'hhspring', 'hhteal', 'hhviolet', 'highlighter_term', 'highlighter_term_bright', 'highwayman', 'hilal', 'holokai', 'hornet', 'horseradish256', 'hotpot', 'hual', 'hybrid-light', 'hybrid', 'hybrid_material', 'hybrid_reverse', 'hydrangea', 'iangenzo', 'ibmedit', 'icansee', 'iceberg', 'immortals', 'impact', 'impactG', 'impactjs', 'industrial', 'industry', 'ingretu', 'inkpot', 'inori', 'ir_black', 'ironman', 'itg_flat', 'itg_flat_transparent', 'itsasoa', 'jaime', 'jammy', 'janah', 'japanesque', 'jelleybeans', 'jellybeans', 'jellygrass', 'jellyx', 'jhdark', 'jhlight', 'jiks', 'jitterbug', 'kalahari', 'kalisi', 'kalt', 'kaltex', 'kate', 'kellys', 'khaki', 'kib_darktango', 'kib_plastic', 'kings-away', 'kiss', 'kkruby', 'koehler', 'kolor', 'kruby', 'kyle', 'laederon', 'lakers_away', 'landscape', 'lanox', 'lanzarotta', 'lapis256', 'last256', 'late_evening', 'lazarus', 'legiblelight', 'leglight2', 'leo', 'less', 'lettuce', 'leya', 'lightcolors', 'lightning', 'lilac', 'lilydjwg_dark', 'lilydjwg_green', 'lilypink', 'lingodirector', 'liquidcarbon', 'literal_tango', 'lizard', 'lizard256', 'lodestone', 'loogica', 'louver', 'lucid', 'lucius', 'luinnar', 'lumberjack', 'luna-term', 'luna', 'lxvc', 'lyla', 'mac_classic', 'macvim-light', 'made_of_code', 'madeofcode', 'magellan', 'magicwb', 'mango', 'manuscript', 'manxome', 'marklar', 'maroloccio', 'maroloccio2', 'maroloccio3', 'mars', 'martin_krischik', 'material-theme', 'material', 'materialbox', 'materialtheme', 'matrix', 'maui', 'mayansmoke', 'mdark', 'mellow', 'messy', 'meta5', 'metacosm', 'midnight', 'miko', 'minimal', 'minimalist', 'mint', 'mizore', 'mod8', 'mod_tcsoft', 'mohammad', 'mojave', 'molokai', 'molokai_dark', 'monoacc', 'monochrome', 'monokai-chris', 'monokai-phoenix', 'monokain', 'montz', 'moody', 'moonshine', 'moonshine_lowcontrast', 'moonshine_minimal', 'mophiaDark', 'mophiaSmoke', 'mopkai', 'more', 'moria', 'moriarty', 'morning', 'moss', 'motus', 'mourning', 'mrkn256', 'mrpink', 'mud', 'muon', 'murphy', 'mushroom', 'mustang', 'mythos', 'native', 'nature', 'navajo-night', 'navajo', 'nazca', 'nedit', 'nedit2', 'nefertiti', 'neodark', 'neon', 'neonwave', 'nerv-ous', 'nes', 'nets-away', 'neuromancer', 'neutron', 'neverland-darker', 'neverland', 'neverland2-darker', 'neverland2', 'neverness', 'nevfn', 'new-railscasts', 'newspaper', 'newsprint', 'nicotine', 'night', 'nightVision', 'night_vision', 'nightflight', 'nightflight2', 'nightshade', 'nightshade_print', 'nightshimmer', 'nightsky', 'nightwish', 'no_quarter', 'noclown', 'nocturne', 'nofrils-acme', 'nofrils-dark', 'nofrils-light', 'nofrils-sepia', 'nord', 'nordisk', 'northland', 'northpole', 'northsky', 'norwaytoday', 'nour', 'nuvola', 'obsidian', 'obsidian2', 'oceanblack', 'oceanblack256', 'oceandeep', 'oceanlight', 'off', 'olive', 'onedark', 'orange', 'osx_like', 'otaku', 'oxeded', 'pablo', 'pacific', 'paintbox', 'paramount', 'parsec', 'peachpuff', 'peaksea', 'pencil', 'penultimate', 'peppers', 'perfect', 'petrel', 'pf_earth', 'phd', 'phoenix', 'phphaxor', 'phpx', 'pink', 'pixelmuerto', 'plasticine', 'playroom', 'pleasant', 'potts', 'predawn', 'preto', 'pride', 'primaries', 'primary', 'print_bw', 'prmths', 'professional', 'proton', 'ps_color', 'pspad', 'pt_black', 'putty', 'pw', 'py-darcula', 'pyte', 'python', 'quagmire', 'quantum', 'radicalgoodspeed', 'raggi', 'railscasts', 'rainbow_autumn', 'rainbow_fine_blue', 'rainbow_fruit', 'rainbow_night', 'rainbow_sea', 'rakr-light', 'random', 'rastafari', 'rcg_gui', 'rcg_term', 'rdark-terminal', 'rdark', 'redblack', 'redstring', 'refactor', 'relaxedgreen', 'reliable', 'reloaded', 'revolutions', 'robinhood', 'rockets-away', 'ron', 'rootwater', 'sadek1', 'sand', 'sandydune', 'satori', 'saturn', 'scheakur', 'scite', 'scooby', 'seagull', 'sean', 'seashell', 'seattle', 'selenitic', 'seoul', 'seoul256-light', 'seoul256', 'seti', 'settlemyer', 'sexy-railscasts', 'sf', 'shades-of-teal', 'shadesofamber', 'shine', 'shiny-white', 'shobogenzo', 'sialoquent', 'sienna', 'sierra', 'sift', 'silent', 'simple256', 'simple_b', 'simple_dark', 'simpleandfriendly', 'simplewhite', 'simplon', 'skittles_autumn', 'skittles_berry', 'skittles_dark', 'sky', 'slate2', 'smarties', 'smp', 'smpl', 'smyck', 'soda', 'softblue', 'softbluev2', 'softlight', 'sol-term', 'sol', 'solarized', 'solarized8_dark', 'solarized8_dark_flat', 'solarized8_dark_high', 'solarized8_dark_low', 'solarized8_light', 'solarized8_light_flat', 'solarized8_light_high', 'solarized8_light_low', 'sole', 'sonofobsidian', 'sonoma', 'sorcerer', 'soruby', 'soso', 'sourcerer', 'southernlights', 'southwest-fog', 'space-vim-dark', 'spacegray', 'spacemacs-theme', 'spartan', 'spectro', 'spiderhawk', 'spring-night', 'spring', 'sprinkles', 'spurs_away', 'srcery-drk', 'srcery', 'stackoverflow', 'stefan', 'stereokai', 'stingray', 'stonewashed-256', 'stonewashed-dark-256', 'stonewashed-dark-gui', 'stonewashed-gui', 'stormpetrel', 'strange', 'strawimodo', 'summerfruit', 'summerfruit256', 'sunburst', 'surveyor', 'swamplight', 'sweater', 'symfony', 'synic', 'synthwave', 'tabula', 'tango-desert', 'tango-morning', 'tango', 'tango2', 'tangoX', 'tangoshady', 'taqua', 'tatami', 'tayra', 'tchaba', 'tchaba2', 'tcsoft', 'telstar', 'tender', 'termschool', 'tesla', 'tetragrammaton', 'textmate16', 'thegoodluck', 'thermopylae', 'thestars', 'thor', 'thornbird', 'tibet', 'tidy', 'tigrana-256-dark', 'tigrana-256-light', 'tir_black', 'tolerable', 'tomatosoup', 'tony_light', 'toothpik', 'torte', 'transparent', 'triplejelly', 'trivial256', 'trogdor', 'tropikos', 'true-monochrome', 'turbo', 'turtles', 'tutticolori', 'twilight', 'twilight256', 'twitchy', 'two-firewatch', 'two2tango', 'ubaryd', 'ubloh', 'umber-green', 'understated', 'underwater-mod', 'underwater', 'unicon', 'up', 'valloric', 'vanzan_color', 'vc', 'vcbc', 'vertLaiton', 'vexorian', 'vibrantink', 'vice', 'vilight', 'vim-material', 'vimbrains', 'vimbrant', 'visualstudio', 'vividchalk', 'void', 'vorange', 'vydark', 'vylight', 'wargrey', 'warm_grey', 'warriors-away', 'wasabi256', 'watermark', 'wellsokai', 'welpe', 'white', 'whitebox', 'whitedust', 'widower', 'wikipedia', 'win9xblueback', 'winter', 'winterd', 'wintersday', 'woju', 'wolfpack', 'wombat', 'wombat256', 'wombat256dave', 'wombat256i', 'wombat256mod', 'wood', 'wuye', 'wwdc16', 'xedit', 'xemacs', 'xian', 'xoria256', 'xterm16', 'yeller', 'yuejiu', 'zazen', 'zellner', 'zen', 'zenburn', 'zenesque', 'zephyr', 'zmrok', 'znake']

" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors(args)
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    call s:SetColors('all')
  endif
  let missing = []
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    call add(missing, s:mycolors[current])
  endif
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /^Vim:E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

" Set color scheme according to current time of day.
function! s:HourColor()
  let hr = str2nr(strftime('%H'))
  if hr <= 3
    let i = 0
  elseif hr <= 7
    let i = 1
  elseif hr <= 14
    let i = 2
  elseif hr <= 18
    let i = 3
  else
    let i = 4
  endif
  let nowcolors = 'elflord morning desert evening pablo'
  execute 'colorscheme '.split(nowcolors)[i]
  redraw
  echo g:colors_name
endfunction
