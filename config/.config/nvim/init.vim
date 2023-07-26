if exists('g:vscode')
    " === VSCode only settings ===

    " The default behavior for ":w!" with the VSCode Neovim extension is to "save as" instead of "save". Fix that here.
    command! -complete=file -nargs=? -bang Write if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.files.save') | endif

endif

" Configure nvim paths to overlap vim paths
let $HOME = getenv('HOME')
set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath
source $HOME/.vimrc
