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

let mapleader = ' '
call plug#begin("~/.vim/plug")

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

Plug 'lewis6991/gitsigns.nvim'

Plug 'neovim/nvim-lspconfig'

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

call plug#end()

let g:NERDDefaultAlign = 'left'

let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = airline#section#create_right(['POS=%l/%L,%c'])

let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_cmd = 'CtrlPMRU'

:lua << EOF
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = true },
    }),
  },
})
EOF

:lua require("dap-python").setup("python")

:lua require('gitsigns').setup()

:lua require("statuscol").setup()

:lua require("treesitter-context").setup()

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

"inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

set tagfunc=CocTagFunc

" No more files called "1" in my cwd
cabbrev w1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w!' : 'w1')<CR>
cabbrev wq1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'wq!' : 'wq1')<CR>

source $HOME/.vimrc
luafile $HOME/.config/nvim/diagnostics.lua
