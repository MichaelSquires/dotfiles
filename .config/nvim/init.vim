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
endif

" Install vim-plug if necessary
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader = ' '
call plug#begin("~/.vim/plug")

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'neovim/nvim-lspconfig'

Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

Plug 'lewis6991/gitsigns.nvim'

Plug 'luukvbaal/statuscol.nvim'

" The following block is all for neotest
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'

" This block is for nvim-dap
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

" Storm syntax highlighting and LSP
Plug 'rakuy0/vim-storm'
Plug 'rakuy0/stormgls', { 'do': ':StormUpdate' }

" Code completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

let g:NERDDefaultAlign = 'left'

let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = airline#section#create_right(['POS=%l/%L,%c'])

let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_cmd = 'CtrlPMRU'

luafile $HOME/.config/nvim/misc.lua

""" Git movement
nnoremap <Leader>j :Gitsigns next_hunk<CR>
nnoremap <Leader>k :Gitsigns prev_hunk<CR>
nnoremap <Leader>p :Gitsigns preview_hunk<CR>

""" Buffer management
nnoremap <Leader>x :bd<CR>

""" Testing
" Run current test
nnoremap <Leader>tc :lua require("neotest").run.run() <CR>
" Debug current test
nnoremap <Leader>td :lua require("neotest").run.run({ strategy = "dap", env = { SYN_REGRESSION_REPO = "/home/blackout/vertex/synapse-regression" } }) <CR> :lua require("dap").repl.toggle() <CR>

" Run current file
nnoremap <Leader>tf :lua require("neotest").run.run(vim.fn.expand("%")) <CR>
" Show test output
nnoremap <Leader>to :lua require("neotest").output_panel.toggle() <CR>
" Show test diagnostics
"nnoremap <Leader>ts :lua require("neotest").diagnostic.toggle() <CR>

""" Debugging
" Toggle breakpoint
nnoremap <Leader>db :lua require("dap").toggle_breakpoint() <CR>
nnoremap <Leader>dc :lua require("dap").continue() <CR>
nnoremap <Leader>dn :lua require("dap").step_over() <CR>
nnoremap <Leader>ds :lua require("dap").step_into() <CR>
nnoremap <Leader>dt :lua require("dap").repl.toggle() <CR>

" The C-_ is actually Ctrl-/
nnoremap <C-_> :call nerdcommenter#Comment('n', 'Toggle') <CR>
vnoremap <C-_> :call nerdcommenter#Comment('x', 'Toggle') <CR>

nnoremap <Bslash> :Rg<CR>

" No more files called "1" in my cwd
cabbrev w1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w!' : 'w1')<CR>
cabbrev wq1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'wq!' : 'wq1')<CR>

source $HOME/.vimrc
luafile $HOME/.config/nvim/diagnostics.lua
