return {
    --
    -- User interface
    --
    { "vim-airline/vim-airline",
        init = function()
            vim.g['airline_theme'] = 'simple'
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
            vim.g['airline_section_z'] = 'POS=%l/%L,%c'
        end,
        dependencies = {
            'vim-airline/vim-airline-themes',
        },
    },

    { 'luukvbaal/statuscol.nvim',
        lazy = false,
        opts = {}
    },

    { "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },

        opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        },

        keys = {
            { "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "[Which-key] Show buffer Local keymaps",
            },
        },
    },

    --
    -- Colorscheme
    --
    { "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,

        init = function()
            vim.g.moonflyTransparent = true
        end,

        config = function()
            vim.cmd([[colorscheme moonfly]])
        end,
    },

    --
    -- File management
    --
    { "junegunn/fzf",
        enabled = false,
        lazy = false,
        name = "fzf",
        build = "./install --bin",
        dependencies = {
            'junegunn/fzf.vim',
        },

        keys = {
            { '<Leader>.',
                ':History<CR>',
                desc = "[Fzf] Open MRU file"
            },
            { '<Leader>o',
                ':Files<CR>',
                desc = "[Fzf] Open file"
            },
            { '<Leader>o',
                ':Files',
                desc = "[Fzf] Open file in specified directory"
            },
            { '<Leader>/',
                ':Rg<CR>',
                desc = "[Fzf] Search files"
            },
        },
    },


    { 'kien/ctrlp.vim',
        --enabled = false,
        init = function()
            vim.g['ctrlp_working_path_mode'] = 0
            vim.g['ctrlp_by_filename'] = 1
            vim.g['ctrlp_cmd'] = 'CtrlPMRU'
            vim.g['ctrlp_extensions'] = { 'dir' }
        end,
    },

    --
    -- Language support
    --
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

    -- Storm language
    { 'rakuy0/vim-storm',
        lazy = false,
        config = function()
            -- For some reason, the ftdetect part of this plugin conflicts with
            -- vim-polyglot. I like the functionality from both so just do the
            -- autocommand here manually.
            vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
                pattern = '*.storm',
                callback = function() vim.bo.filetype = 'storm' end,
            })
        end,
    },
    { 'rakuy0/stormgls',
        --lazy = false,
        ft = 'storm',
        event = 'BufEnter *.storm',
        dependencies = {
            'rakuy0/vim-storm',
            'neovim/nvim-lspconfig',
        },
        build = ':StormUpdate',
    },

    --
    -- Code completion
    --
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },

        opts = function(_, opts)
            local cmp = require'cmp'

            local winhighlight = {
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
            }

            opts.snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                end,
            }

            opts.window = {
                completion = cmp.config.window.bordered(winhighlight),
                documentation = cmp.config.window.bordered(winhighlight),
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

    --
    -- Commenting
    --
    { "scrooloose/nerdcommenter",
        keys = {
            -- <C-_> is Ctrl-/
            { "<C-_>", ":call nerdcommenter#Comment('x', 'Toggle')<CR>", mode = "v", desc = "Toggle comments (visual)" },
            { "<C-_>", ":call nerdcommenter#Comment('n', 'Toggle')<CR>", mode = "n", desc = "Toggle comments (normal)" },
        },

        init = function()
            vim.g['NERDDefaultAlign'] = 'left'
        end,

        opts = {},
    },

    --
    -- Version control
    --
    { 'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = {},
        keys = {
            { '<Leader>j',
                ':Gitsigns next_hunk<CR>',
                desc = "[Git] Go to next change"
            },

            { '<Leader>k',
                ':Gitsigns prev_hunk<CR>',
                desc = "[Git] Go to previous change"
            },

            { '<Leader>p',
                ':Gitsigns preview_hunk<CR>',
                desc = "[Git] Preview change"
            },
        },
    },

    --
    -- Testing
    --
    { 'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/nvim-nio',
            'nvim-neotest/neotest-python',
            'mfussenegger/nvim-dap',
        },

        keys = {

            { '<Leader>t.',
                function()
                    require('neotest').run.run({
                        strategy = 'dap',
                        env = {
                            SYN_REGRESSION_REPO = "/home/blackout/vertex/synapse-regression"
                        }
                    })
                end,
                desc = "[Test] debug current test"
            },

            { '<Leader>tc',
                function() require('neotest').run.run() end,
                desc = "[Test] run Current test"
            },

            { '<Leader>tf',
                function() require('neotest').run.run(vim.fn.expand('%')) end,
                desc = "[Test] run current File"
            },

            { '<Leader>to',
                function() require("neotest").output_panel.toggle() end,
                desc = "[Test] toggle Output panel"
            },

            { '<Leader>td',
                function() require("neotest").diagnostic.toggle() end,
                desc = "[Test] toggle Diagnostics"
            },
        },

        opts = function(_, opts)
            opts.adapters = {
                require("neotest-python")({
                    dap = { justMyCode = true },
                }),
            }
        end,
    },

    --
    -- Debugging
    --
    { 'mfussenegger/nvim-dap',
        opts = {
            initialize_timeout_sec = 10,
        },

        dependencies = {
            'mfussenegger/nvim-dap-python',
        },

        keys = {
            { '<Leader>d.',
                function() require('dap').toggle_breakpoint() end,
                desc = "[Debug] toggle breakpoint"
            },

            { '<Leader>dc',
                function() require('dap').continue() end,
                desc = "[Debug] Continue"
            },

            { '<Leader>dn',
                function() require('dap').step_over() end,
                desc = "[Debug] Next (step over)"
            },

            { '<Leader>ds',
                function() require('dap').step_into() end,
                desc = "[Debug] Step into"
            },

            { '<Leader>dt',
                function() require('dap').repl.toggle() end,
                desc = "[Debug] Toggle repl"
            },
        },

        config = function()
            require('dap-python').setup('python')
        end,
    },

    { "rcarriga/nvim-dap-ui",
        opts = {},

        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },

        keys = {
            { '<Leader>du',
                function() require("dapui").toggle() end,
                desc = "[Debug] toggle User iterface"
            },
        },

        init = function()
            local dap, dapui = require("dap"), require("dapui")

            dap.listeners.before.attach.dapui_config = function()
              dapui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
              dapui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
              dapui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
              dapui.close()
            end
        end,
    },
}
