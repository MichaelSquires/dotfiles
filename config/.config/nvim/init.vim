if exists('g:vscode')
    " === VSCode only settings ===

    " The default behavior for ":w!" with the VSCode Neovim extension is to "save as" instead of "save". Fix that here.
    command! -complete=file -nargs=? -bang Write if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.files.save') | endif

endif

" Resolve relative path to vim dir
let $CFGDIR = stdpath('config')
let $VIMDIR = '$CFGDIR/../../../vim/'

" Configure nvim paths to overlap vim paths
set runtimepath^=$VIMDIR/.vim runtimepath+=$VIMDIR/.vim/after
let &packpath = &runtimepath
source $VIMDIR/.vimrc
