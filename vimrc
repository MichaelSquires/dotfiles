set ai

set syn=on
syntax on

set number
set hlsearch
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set cursorline
set cursorcolumn

set textwidth=120

set ignorecase
set smartcase

set list
set listchars=eol:$,tab:\|-,trail:~,extends:>,precedes:<

" Get zenburn from: https://raw.githubusercontent.com/jnurmine/Zenburn/master/colors/zenburn.vim
" Install to 
"   - *nix: ~/.vim/colors 
"   - Windows (all users): c:\vim\colors 
"   - Windows (current user): c:\Users\<username>\vimfiles\colors
set t_Co=256
let g:zenburn_alternate_Visual=1
let g:zenburn_high_Contrast=1
let g:zenburn_transparent=1
colorscheme zenburn
"colorscheme darkblue

" Get monaco from: https://code.google.com/p/usystem/downloads/detail?name=MONACO.TTF
"set guifont=monaco:h8

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=%03.3b:0x%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
