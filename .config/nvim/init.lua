-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.cmd([[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]])

vim.g['python3_host_prog'] = '~/.pyenv/versions/neovim/bin/python3'

-- Set these in lua so we can have descriptions
vim.keymap.set('n', '<Leader>x', ':bd<CR>', { desc = '[Buffer] Close buffer' })
vim.keymap.set('n', '<Leader>l', ':Lazy<CR>', { desc = '[Lazy.nvim] Open panel' })

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = true,  -- Or "if_many"
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = true,
        }
    )
