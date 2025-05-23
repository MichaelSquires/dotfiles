return {
    --
    -- User interface
    --
    { "vim-airline/vim-airline",
        enabled = false,
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

    { 'nvim-lualine/lualine.nvim',
        --enabled = false,
        opts = {
            sections = {
                lualine_b = {'diff', 'diagnostics'},
            },

            tabline = {
                lualine_a = {'buffers'},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'tabs'},
            },

            options = {
                disabled_filetypes = {
                    'ctrlp',
                },
            },

            extensions = {
                'nvim-dap-ui',
                'lazy',
            },
        },

        dependencies = { 'nvim-tree/nvim-web-devicons' },
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

        opts = {},

        keys = {
            { "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "[Which-key] Show buffer Local keymaps",
            },
        },
    },

    { "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
            },

            indent = {
                enable = true,
            },
        }
    },

    { "stevearc/quicker.nvim",
        event = "FileType qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },

    { "LunarVim/bigfile.nvim",
        opts = {},
    },

    --
    -- Text editing
    --
    { 'echasnovski/mini.surround',
        version = '*',
        opts = {},
    },

    --
    -- Colorscheme
    --
    { "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,

        init = function()
            --vim.g.moonflyTransparent = true
            vim.g.moonflyNormalFloat = true

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = "single"
                }
            )

            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signatureHelp, {
                    border = "single"
                }
            )

            vim.diagnostic.config({ float = { border = "single" } })

        end,

        config = function()
            -- These get overwritten by the plugin, put them back
            vim.cmd([[colorscheme moonfly]])
            vim.cmd([[hi Normal ctermbg=NONE]])
            vim.cmd([[hi Normal guibg=NONE]])
            vim.cmd([[hi Cursorline guibg=#080808]])
            vim.cmd([[hi Cursorcolumn guibg=#080808]])
        end,
    },

    --
    -- File management
    --
    { "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        keys = {
                { '',
                    ':Neotree position=float reveal toggle<CR>',
                    desc = "[File] Toggle file tree"
                },
        },

        opts = {
            event_handlers = {
                { -- Auto-close file browser when a file is opened
                    event = "file_open_requested",
                    handler = function()
                        -- auto close
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
        },
    },

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

    { 'ctrlpvim/ctrlp.vim',
        enabled = false,
        init = function()
            vim.g['ctrlp_working_path_mode'] = 0
            vim.g['ctrlp_by_filename'] = 1
            vim.g['ctrlp_cmd'] = 'CtrlPMRU'
            vim.g['ctrlp_extensions'] = { 'dir' }
        end,
    },

    { "ibhagwan/fzf-lua",
        enabled = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { '',
                ':FzfLua files<CR>',
                desc = "[FzfLua] Open file"
            },
        },
    },

    --
    -- Language support
    --
    { "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").pylsp.setup{
                settings = {
                    plugins = {
                        flake8 = {
                            enabled = true
                        }
                    }
                }
            }

            require("lspconfig").rust_analyzer.setup{
                settings = {
                    ['rust-analyzer'] = {},
                },
            }
        end,
    },

    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                -- highlight = { enable = true },
                ensure_installed = {"python", "vimdoc", "ebnf", "rust"},
            })

            vim.treesitter.language.register("ebnf", "lark")
            vim.filetype.add { extension = { lark = 'ebnf' } }
        end,

        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    multiline_threshold = 7,
                }
            },
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
        --enabled = false,
        ft = 'storm',
        event = 'BufEnter *.storm',
        dependencies = {
            'rakuy0/vim-storm',
            'neovim/nvim-lspconfig',
        },
        build = ':StormUpdate',
        branch = 'master',
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
                    { name = 'nvim_lsp_signature_help' },
                }, {
                    { name = 'buffer' },
            })

            opts.formatting = {
                format = function(entry, vim_item)

                    -- Kind icons
                    local kind_icons = {
                        -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
                        Text = " ",
                        Method = "󰆧",
                        Function = "ƒ ",
                        Constructor = " ",
                        Field = "󰜢 ",
                        Variable = " ",
                        Constant = " ",
                        Class = " ",
                        Interface = "󰜰 ",
                        Struct = " ",
                        Enum = "了 ",
                        EnumMember = " ",
                        Module = "",
                        Property = " ",
                        Unit = " ",
                        Value = "󰎠 ",
                        Keyword = "󰌆 ",
                        Snippet = " ",
                        File = " ",
                        Folder = " ",
                        Color = " ",
                    }
                    -- This concatonates the icons with the name of the item kind
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

                    -- Source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[NvimAPI]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            }
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
            vim.g['NERDCustomDelimiters'] = { storm = { left = '//', leftAlt = '//' } }
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
