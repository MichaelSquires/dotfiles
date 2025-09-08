set encoding=utf-8
set visualbell

set foldmethod=indent
set nofen

"set autochdir
set termguicolors

let mapleader = " "
let maplocalleader = "\\"

" Auto-indent
set ai
"set formatoptions-=t

" Show line numbers
set number

" Syntax highlighting
set syn=on
"syntax on

" Top/bottom of screen buffer when scrolling
set scrolloff=15

" Highlight the current row/column
set cursorline
set cursorcolumn

" Status line
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=%03.3b:0x%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set laststatus=2

" Refresh window
set updatetime=250

" Set tab behavior
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set textwidth=120
autocmd FileType * setlocal textwidth=120
autocmd FileType rst setlocal textwidth=80

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
"let g:zenburn_alternate_Visual=1
"let g:zenburn_high_Contrast=1
"let g:zenburn_transparent=1
hi Normal ctermbg=NONE
hi Normal guibg=NONE
hi Cursorline guibg=#080808
hi Cursorcolumn guibg=#080808

" Switch buffers easily with TAB and SHIFT-TAB
:nnoremap <Tab> :bn<CR>
:nnoremap <S-Tab> :bp<CR>
:nnoremap <Leader>x :bd<CR>

" copy and paste to/from system clipboard
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set guifont=Fira_Code_Retina:h8

" vim-rainbow
let g:rainbow_active = 1

" lightline
"set noshowmode

" No more files called "1" in my cwd
cabbrev w1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w!' : 'w1')<CR>
cabbrev wq1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'wq!' : 'wq1')<CR>
