set encoding=utf-8
set visualbell

set foldmethod=indent
set nofen

" Auto-indent
set ai

" Syntax highlighting
set syn=on
syntax on

" Show line numbers
set number

" Set tab behavior
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Highlight the current row/column
set cursorline
set cursorcolumn

" Auto-newline
set textwidth=180

" Smarter searching
set hlsearch
set smartcase
set ignorecase

" This is for file-watching services
set backupcopy=yes

" Filetype specific options
filetype plugin on

" Disable auto-comments
set formatoptions-=o
autocmd FileType * setlocal formatoptions-=o

" Backspace behavior to be more intuitive
set backspace=indent,eol,start

" Show whitespace
set list
set listchars=tab:»\ ,extends:›,precedes:‹,trail:•

" Color scheme
set t_Co=256
let g:zenburn_alternate_Visual=1
let g:zenburn_high_Contrast=1
let g:zenburn_transparent=1
colorscheme zenburn

" Switch buffers easily with TAB and SHIFT-TAB
:nnoremap <Tab> :tabn<CR>
:nnoremap <S-Tab> :tabp<CR>

set guifont=Fira_Code:h8

" Status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=%03.3b:0x%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Refresh window
set updatetime=250

" vim-rainbow
let g:rainbow_active = 1

" lightline
set noshowmode
