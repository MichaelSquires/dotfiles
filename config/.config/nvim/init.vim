let $HOME = getenv('HOME')
set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath
if exists('g:vscode')
    " === VSCode only settings ===

    " The default behavior for ":w!" with the VSCode Neovim extension is to "save as" instead of "save". Fix that here.
    command! -complete=file -nargs=? -bang Write if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.files.save') | endif

    set encoding=utf-8
    set smartcase
    set ignorecase

    " synch clipboard and default register
    set clipboard=unnamedplus


else
    let mapleader = ' '
    call plug#begin("~/.vim/plug")

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'kien/ctrlp.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'scrooloose/nerdcommenter'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

    Plug 'wellle/context.vim'

    Plug 'lewis6991/gitsigns.nvim'

    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

    call plug#end()

    let g:NERDDefaultAlign = 'left'

    let g:airline_theme = 'simple'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline_section_z = airline#section#create_right(['POS=%l/%L,%c'])

    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_by_filename = 1
    let g:ctrlp_cmd = 'CtrlPMRU'

    let g:doge_doc_standard_python = 'google'
    let g:doge_python_settings = {'single_quotes': 1, 'omit_redundant_param_types': 0}

    lua require('gitsigns').setup()

    nnoremap <Leader>gn :Gitsigns next_hunk<CR>
    nnoremap <Leader>gp :Gitsigns prev_hunk<CR>
    nnoremap <Leader>gd :Gitsigns preview_hunk<CR>
    nnoremap <silent> <Leader>d <Plug>(doge-generate)

    nnoremap <C-_> :call nerdcommenter#Comment('n', 'Toggle')<CR>
    vnoremap <C-_> :call nerdcommenter#Comment('x', 'Toggle')<CR>

    nnoremap <Bslash> :Rg<CR>

    inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
    set tagfunc=CocTagFunc

    source $HOME/.vimrc
    luafile $HOME/.config/nvim/diagnostics.lua
endif

" No more files called "1" in my cwd
cabbrev w1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w!' : 'w1')<CR>
