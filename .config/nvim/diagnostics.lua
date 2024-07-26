--vim.diagnostic.config({
--  virtual_text = {
--    source = "if_many",
--    prefix = '●', -- Could be '■', '▎', 'x'
--  },
--  severity_sort = true,
--  float = {
--    source = true,  -- Or "if_many"
--  },
--})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = true,
    }
)
