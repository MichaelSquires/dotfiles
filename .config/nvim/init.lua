-- Load base vim settings first
vim.cmd([[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]])

-- Set python binary
vim.g['python3_host_prog'] = '~/.pyenv/versions/neovim/bin/python3'

-- lazy.nvim plugin manager
require("config.lazy")

-- Set these in lua so we can have descriptions
vim.keymap.set('n', '<Leader>x', ':bd<CR>', { desc = '[Buffer] Close buffer' })
vim.keymap.set('n', '<Leader>l', ':Lazy<CR>', { desc = '[Lazy.nvim] Open panel' })

vim.keymap.set('n', '<Leader>qo', ':copen<CR>', { desc = '[Quickfix] Open quickfix panel' })
vim.keymap.set('n', '<Leader>qc', ':ccl<CR>', { desc = '[Quickfix] Close quickfix panel' })
vim.keymap.set('n', '<Leader>qn', ':cn<CR>', { desc = '[Quickfix] Goto next error' })
vim.keymap.set('n', '<Leader>qp', ':cp<CR>', { desc = '[Quickfix] Goto previous error' })

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
