if exists('g:vscode')
    " === VSCode only settings ===

    " The default behavior for ":w!" with the VSCode Neovim extension is to "save as" instead of "save". Fix that here.
    command! -complete=file -nargs=? -bang Write if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.files.save') | endif

endif

" Import vim plugins and settings
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
