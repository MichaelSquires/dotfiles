require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = true },
    }),
  },
})

require("dap-python").setup("python")

require('gitsigns').setup()

require("statuscol").setup()

require("nvim-treesitter.configs").setup({
    ensure_installed = {"python", "vimdoc"},
})

require("treesitter-context").setup()

 local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },

    window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})

require("lspconfig").pylsp.setup{}
