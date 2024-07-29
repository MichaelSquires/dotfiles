-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = ""
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.cmd([[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]])

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
