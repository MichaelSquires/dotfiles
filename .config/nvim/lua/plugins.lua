return {
    -- User interface
    { "vim-airline/vim-airline",
        init = function()
            vim.g['airline_theme'] = 'simple'
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
            --vim.g['airline_section_z'] = vim.cmd([[airline#section#create_right(['POS=%l/%L,%c'])]])
        end,
        dependencies = {
            'vim-airline/vim-airline-themes',
        },
    },

    -- Colorscheme
    { "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme moonfly]])
        end,
    },

    -- File management
    { "junegunn/fzf",
        enabled = false,
        name = "fzf",
        dir = "~/.fzf",
        build = "./install --all",
        dependencies = {
            'junegunn/fzf.vim',
        },
    },

    { 'kien/ctrlp.vim',
        --enabled = false
        init = function()
            vim.g['ctrlp_working_path_mode'] = 0
            vim.g['ctrlp_by_filename'] = 1
            vim.g['ctrlp_cmd'] = 'CtrlPMRU'
        end,
    },

    -- Language support
    { "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").pylsp.setup{}
        end,
    },
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        opts = {
            ensure_installed = {"python", "vimdoc"},
        },

        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context", opts = {} },
        },
    },

    { 'sheerun/vim-polyglot' },

    -- Code completion
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },

        opts = function(_, opts)
            local cmp = require'cmp'

            opts.snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                end,
            }

            opts.window = {
                --completion = cmp.config.window.bordered(),
                --documentation = cmp.config.window.bordered(),
            }

            opts.mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),

                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })

            opts.sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
            })
        end,
    },

    -- Storm support
    { 'rakuy0/vim-storm' },
    { 'rakuy0/stormgls', build = ':StormUpdate' },

    -- Commenting
    { "scrooloose/nerdcommenter",
        keys = {
            { "<C-_>", ":call nerdcommenter#Comment('x', 'Toggle')<CR>", mode = "v", desc = "Toggle comments (visual)" },
            { "<C-_>", ":call nerdcommenter#Comment('n', 'Toggle')<CR>", mode = "n", desc = "Toggle comments (normal)" },
        },

        init = function()
            vim.g['NERDDefaultAlign'] = 'left'
        end,

        opts = {},
    },

    -- Version control
    { 'lewis6991/gitsigns.nvim',
        opts = {},
        keys = {
            { '<Leader>j', ':Gitsigns next_hunk<CR>' },
            { '<Leader>k', ':Gitsigns prev_hunk<CR>' },
            { '<Leader>p', ':Gitsigns preview_hunk<CR>' },
        },
    },
    { 'luukvbaal/statuscol.nvim', opts = {} },

    -- Testing
    { 'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/nvim-nio',
            'nvim-neotest/neotest-python',
        },

        keys = {

            -- Run current test
            { '<Leader>tc', function() require('neotest').run.run() end },

            -- Debug current test
            { '<Leader>td', function()
                    require('neotest').run.run({
                        strategy = 'dap',
                        env = {
                            SYN_REGRESSION_REPO = "/home/blackout/vertex/synapse-regression"
                        }
                    })

                    require("dap").repl.toggle()
                end
            },

            -- Run current file
            { '<Leader>tf', function() require('neotest').run.run(fim.fn.expand('%')) end },

            -- Show test output
            { '<Leader>to', function() require("neotest").output_panel.toggle() end },

            -- Show test diagnostics
            { '<Leader>ts', function() require("neotest").diagnostic.toggle() end },
        },

        opts = function(_, opts)
            opts.adapters = {
                require("neotest-python")({
                    dap = { justMyCode = true },
                }),
            }
        end,
    },

    -- Debugging
    { 'mfussenegger/nvim-dap',
        dependencies = {
            'mfussenegger/nvim-dap-python',
        },

        keys = {
            { '<Leader>db', function() require('dap').toggle_breakpoint() end },
            { '<Leader>dc', function() require('dap').continue() end },
            { '<Leader>dn', function() require('dap').step_over() end },
            { '<Leader>ds', function() require('dap').step_into() end },
            { '<Leader>dt', function() require('dap').repl.toggle() end },
        },

        config = function()
            require('dap-python').setup('python')
        end,
    },
}
