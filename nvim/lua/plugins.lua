-- local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
-- end

local plugins = {
    ['lspconfig'] = {
        active = true,
        config = function()
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                severity_sort = true
            }
            )
            local nvim_lsp = require 'lspconfig'
            local on_attach = function(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local opts = { noremap = true, silent = true }
                -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
                -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
                vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
            end

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            nvim_lsp['bashls'].setup{
                cmd = {"node", "--experimental-wasm-reftypes","/usr/bin/bash-language-server"};
            }
            --nvim_lsp['sumneko_lua'].setup{
            --  cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server"};
            --}

            nvim_lsp['lua_ls'].setup{
                on_attach = on_attach,
                cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server"},
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'},
                        },
                        completion = {
                            callSnippet = "Disable",
                            keywordSnippet = "Disable",
                        },
                    },
                },
            }

            nvim_lsp['pylsp'].setup {
                on_attach = on_attach,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {'E501'},
                                maxLineLength = 100
                            }
                        }
                    }
                }
            }

            local ng_project_library_path = ""
            nvim_lsp['angularls'].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {"ngserver", "--stdio", "--tsProbeLocations", ng_project_library_path , "--ngProbeLocations", ng_project_library_path },
                on_new_config = function(new_config,new_root_dir)
                    new_config.cmd = {"ngserver", "--stdio", "--tsProbeLocations", ng_project_library_path , "--ngProbeLocations", ng_project_library_path}
                end,
                root_dir = function()
                    return vim.fn.expand('%:p:h')
                end

            }

            nvim_lsp['clangd'].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            -- nvim_lsp['eslint'].setup {
            --     on_attach = on_attach,
            --     capabilities = capabilities,
            --     -- root_dir = function()
            --     --     return "/home/guillaume/medic-node"
            --     -- end,
            --     cmd = { 'eslint-language-server', '--stdio' }
            -- }

            nvim_lsp['ts_ls'].setup{
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "typescript-language-server", "--stdio" },
                handlers = {
                    ["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _, config)
                        if params.diagnostics ~= nil then
                            local idx = 1
                            while idx <= #params.diagnostics do
                                if params.diagnostics[idx].code == 80001 then
                                    table.remove(params.diagnostics, idx)
                                else
                                    idx = idx + 1
                                end
                            end
                        end
                        -- vim.lsp.diagnostic.on_publish_diagnostics(_, _, params, client_id, _, config)
                    end,
                },
                -- root_dir = function()
                --     return "/home/guillaume/medic-node/"
                -- end
                -- root_dir = function()
                --     return vim.fn.expand('%:p:h')
                -- end
            }
            
            -- nvim_lsp.jdtls.setup {
            --     cmd = {
            --         'java',
            --         '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            --         '-Dosgi.bundles.defaultStartLevel=4',
            --         '-Declipse.product=org.eclipse.jdt.ls.core.product',
            --         '-Dlog.protocol=true',
            --         '-Dlog.level=ALL',
            --         '-Xms1g',
            --         '--add-modules=ALL-SYSTEM',
            --         '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            --         '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            --         '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
            --         '-configuration', '/usr/share/java/jdtls/config_linux',
            --         '-data', os.getenv "HOME" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            --     },
            --     -- root_dir = require'jdtls'.setup.find_root({'.git', 'mvnw', 'gradlew'}),
            --     settings = {
            --         java = {
            --         }
            --     },
            --     init_options = {
            --         bundles = {}
            --     },
            --     on_attach = on_attach
            -- }

            nvim_lsp.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importGranularity = "module",
                            importPrefix = "by_self",
                        },
                        cargo = {
                            loadOutDirsFromCheck = true
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                }
            })
        end,
        -- use = { 'neovim/nvim-lspconfig', requires = {'folke/lsp-colors.nvim', 'kyazdani42/nvim-web-devicons'} },
        use = { 'neovim/nvim-lspconfig', 'folke/lsp-colors.nvim', 'kyazdani42/nvim-web-devicons' },
    },

    ['git'] = {
        active = true,
        config = function()
            vim.g.gitgutter_sign_priority = 5
        end,
        use = { 'tpope/vim-fugitive', 'junegunn/gv.vim', 'airblade/vim-gitgutter' },
    },

    ['noice'] = {
        active = false,
        config = function()
            require'noice'.setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
        use = {
            "folke/noice.nvim",
            -- requires = {
                -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
                -- OPTIONAL:
                --   `nvim-notify` is only needed, if you want to use the notification view.
                --   If not available, we use `mini` as the fallback
                -- "rcarriga/nvim-notify",
            -- },
        },
    },
    ['telescope'] = {
        active = true,
        config = function()
            local status, local_nvim = pcall(require, 'local.local_nvim')

            local find_files_searchdirs = {}
            local live_grep_searchdirs = {}

            if status then
                find_files_searchdirs = local_nvim.find_files_searchdirs or {}
                live_grep_searchdirs = local_nvim.live_grep_searchdirs or {}
            else
                print("Le module local_nvim n'a pas été trouvé.")
            end

            require('telescope').setup {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--color=never",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    path_display = { "shorten" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    use_less = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                },
                pickers = {
                    find_files = {
                        find_command = {
                            'fd',
                            '--type',
                            'f',
                            '--no-ignore-vcs',
                            '--color=never',
                            '--follow',
                        },
                        search_dirs = find_files_searchdirs
                    },
                    live_grep = {
                        only_cwd = true,
                        search_dirs = live_grep_searchdirs
                    },
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = false, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    media_files = {
                        filetypes = { "png", "webp", "jpg", "jpeg" },
                        find_cmd = "rg", -- find command (defaults to `fd`)
                    },
                },
            }
        end,
        use = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    },
    ['nvimtree'] = {
        active = false,
        config = function()
            require'nvim-tree'.setup {
                -- BEGIN_DEFAULT_OPTS
                auto_reload_on_write = true,
                disable_netrw = false,
                hijack_cursor = false,
                hijack_netrw = true,
                hijack_unnamed_buffer_when_opening = false,
                ignore_buffer_on_setup = false,
                open_on_setup = false,
                open_on_setup_file = false,
                open_on_tab = false,
                sort_by = "name",
                update_cwd = false,
                view = {
                    width = 30,
                    hide_root_folder = false,
                    side = "left",
                    preserve_window_proportions = false,
                    number = false,
                    relativenumber = false,
                    signcolumn = "yes",
                    mappings = {
                        custom_only = false,
                        list = {
                            -- user mappings go here
                        },
                    },
                },
                renderer = {
                    indent_markers = {
                        enable = false,
                        icons = {
                            corner = "└ ",
                            edge = "│ ",
                            none = "  ",
                        },
                    },
                    icons = {
                        webdev_colors = true,
                    },
                },
                hijack_directories = {
                    enable = true,
                    auto_open = true,
                },
                update_focused_file = {
                    enable = false,
                    update_cwd = false,
                    ignore_list = {},
                },
                ignore_ft_on_setup = {},
                system_open = {
                    cmd = "",
                    args = {},
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                    exclude = {},
                },
                git = {
                    enable = false,
                    ignore = true,
                    timeout = 400,
                },
                actions = {
                    use_system_clipboard = true,
                    change_dir = {
                        enable = true,
                        global = false,
                        restrict_above_cwd = false,
                    },
                    open_file = {
                        quit_on_open = false,
                        resize_window = false,
                        window_picker = {
                            enable = true,
                            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                            exclude = {
                                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                                buftype = { "nofile", "terminal", "help" },
                            },
                        },
                    },
                },
                trash = {
                    cmd = "trash",
                    require_confirm = true,
                },
                log = {
                    enable = false,
                    truncate = false,
                    types = {
                        all = false,
                        config = false,
                        copy_paste = false,
                        diagnostics = false,
                        git = false,
                        profile = false,
                    },
                },
            } -- END_DEFAULT_OPTS
            vim.cmd[[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif ]]
        end,
        use = { 'kyazdani42/nvim-tree.lua' },
    },
    ['neotree'] = {
        active = true,
        config = function()
            require("neo-tree").setup({
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = "✚",
                            deleted   = "✖",
                            modified  = "",
                            renamed   = "",
                            -- Status type
                            -- untracked = "",
                            -- ignored   = "",
                            -- unstaged  = "",
                            -- staged    = "",
                            -- conflict  = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                        },
                    },
                },
                close_if_last_window = true,
            })
        end,
        use = {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            -- requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            -- }
        },
    },
    ['cmp'] = {
        active = true,
        config = function()
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if not cmp_status_ok then
                return
            end
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            if not snip_status_ok then
                return
            end

            --   פּ ﯟ   some other good icons
            local kind_icons = {
                Text = "",
                Method = "m",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                TypeParameter = "",
            }
            -- find more here: https://www.nerdfonts.com/cheat-sheet

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    ['<C-l>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
                    { name = "path" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        vim_item.menu = ({
                            luasnip = "[Snippet]",
                            nvim_lsp = "[LSP]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
        use = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
        }
    },
    ['fzf'] = {
        active = true,
        config = function()
            require'lspfuzzy'.setup{}
        end,
        use = {  'ojroques/nvim-lspfuzzy',
        -- requires = {
            {'junegunn/fzf'},
            {'junegunn/fzf.vim'}}, -- to enable preview (optional)
        -- },
    },
    ['dashboard'] = {
        active = false,
        config = function()
            local g = vim.g

            g.dashboard_disable_at_vimenter = 0
            g.dashboard_disable_statusline = 1
            g.dashboard_default_executive = "telescope"
            g.dashboard_custom_header = {
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                "",
                "",
                "",
                "",

            }

            g.dashboard_custom_section = {
                a = { description = { "  Load Session              \\ s s" }, command = "lua require'persistence'.load()" },
                b = { description = { "  Find File                 \\ f f" }, command = "Telescope find_files" },
                c = { description = { "  Recents                   \\ f o" }, command = "Telescope oldfiles" },
                d = { description = { "  Find Word                 \\ f g" }, command = "Telescope live_grep" },
            }

            g.dashboard_custom_footer = {
                "NVIM",
            }
            -- local db = require('dashboard')
            -- db.custom_header  -- type can be nil,table or function(must be return table in function)
            --                   -- if not config will use default banner
            -- db.custom_center  -- table type and in this table you can set icon,desc,shortcut,action keywords. desc must be exist and type is string
            --                   -- icon type is nil or string
            --                   -- shortcut type is nil or string also like icon
            --                   -- action type can be string or function or nil.
            --                   -- if you don't need any one of icon shortcut action ,you can ignore it.
            -- db.custom_footer  -- type can be nil,table or function(must be return table in function)
            -- db.preview_file_Path    -- string type 
            -- db.preview_file_height  -- string type
            -- db.preview_file_width   -- string type
            -- db.preview_command      -- string type
            -- db.hide_statusline      -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
            -- db.hide_tabline         -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer
            -- db.session_directory    -- string type the directory to store the session file
            -- 
            -- -- example of db.custom_center for new lua coder,the value of nil mean if you
            -- -- don't need this filed you can not write it
            -- db.custom_center = {
            --   { icon = 'some icon' desc = 'some description here' } --correct if you don't action filed
            --   { desc = 'some description here' }                    --correct if you don't action and icon filed
            --   { desc = 'some description here' action = 'Telescope find files'} --correct if you don't icon filed
            -- }
        end,
        use = { 'glepnir/dashboard-nvim' }
    },
    ['alpha'] = {
        active = false,
        config = function()
            local alpha = require'alpha'
            local dashboard = require'alpha.themes.dashboard'
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("\\ s s", "  Load Session", ":lua require'persistence'.load()<CR>"),
                dashboard.button("\\ f f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("\\ f g", "  Find Word", ":Telescope live_grep<CR>"),
                dashboard.button("\\ f o", "  Recents", ":Telescope oldfiles<CR>"),
            }
            -- local handle = io.popen('fortune')
            -- local fortune = handle:read("*a")
            -- handle:close()
            -- dashboard.section.footer.val = fortune
            -- dashboard.config.opts.noautocmd = true
            -- vim.cmd[[autocmd User AlphaReady echo 'ready']]
            -- alpha.setup(dashboard.config)


            local fortune = require("alpha.fortune")
            dashboard.section.footer.val = fortune()

            alpha.setup(dashboard.opts)

            -- Send config to alpha
            alpha.setup(dashboard.opts)
        end,
        use = { 'goolord/alpha-nvim' },
    },
    ['whichkeys'] = {
        active = false,
        config = function()
            require'which-key'.setup{
                hide_statusline = false,
                default_keymap_settings = {
                    silent=true,
                    noremap=true,
                },
                default_mode = 'n',
            }
        end,
        use = { "folke/which-key.nvim" }
    },
    ['term'] = {
        active = true,
        config = function()
            require("toggleterm").setup{
                shading_factor = 0
            }

            local Terminal  = require('toggleterm.terminal').Terminal

            local reg_term = Terminal:new({
                direction = 'horizontal',
            })

            local git = Terminal:new({
                cmd = "gitui",
                dir = "git_dir",
                direction = "float",
                float_opts = {
                    border = "double",
                    width = 160,
                    height = 100,
                },
                on_open = function(term)
                    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
                end,
            })

            function GitToggle()
                git:toggle()
            end

            function TermToggle()
                reg_term:toggle()
            end
        end,
        use = { 'akinsho/toggleterm.nvim' },
    },
    ['undotree'] = {
        active = true,
        config = function()
        end,
        use = { 'mbbill/undotree' }
    },
    ['neoclip'] = {
        active = true,
        config = function()
            require('neoclip').setup({
                history = 1000,
                persistant_enable_history = false,
                db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
                filter = nil,
                preview = true,
                default_register = '"',
                default_register_macros = 'q',
                enable_macro_history = true,
                content_spec_column = false,
                on_paste = {
                    set_reg = false,
                },
                on_replay = {
                    set_reg = false,
                },
                keys = {
                    telescope = {
                        i = {
                            select = '<cr>',
                            paste = '<c-p>',
                            paste_behind = '<c-k>',
                            replay = '<c-q>',
                            custom = {},
                        },
                        n = {
                            select = '<cr>',
                            paste = 'p',
                            paste_behind = 'P',
                            replay = 'q',
                            custom = {},
                        },
                    },
                    fzf = {
                        select = 'default',
                        paste = 'ctrl-p',
                        paste_behind = 'ctrl-k',
                        custom = {},
                    },
                },
            })
        end,
        -- use = { 'AckslD/nvim-neoclip.lua', requires = {'tami5/sqlite.lua', module = 'sqlite'} }
        use = { 'AckslD/nvim-neoclip.lua', 'tami5/sqlite.lua' },
    },
    ['snippets'] = {
        active = true,
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            ---- Using vscode : Use the lazy loader down below and copy friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {
                    "/home/guillaume/.config/nvim/snippets",
                }})
            end,
            use = { 'rafamadriz/friendly-snippets' }
    },
    ['delimit'] = {
        active = false,  -- Désactivé car freeze avec Ctrl+O
        config = function()
        end,
        use = { 'Raimondi/delimitMate' }
    },
    ['lightline'] = {
        active = false,
        config = function()
            local o = require('options')

            vim.g.lightline = {
                colorscheme = o.lightline_theme,
                active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
                component_function = { gitbranch = 'fugitive#head' },
            }
        end,
        use = { 'itchyny/lightline.vim' }
    },
    ['treesitter'] = {
        active = false,
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = function(lang, bufnr)
                        return vim.api.nvim_buf_line_count(bufnr) > 50000
                    end,
                    use_languagetree = true,
                },
            }
        end,
        use = { 'nvim-treesitter/nvim-treesitter' }
    },
    ['comment'] = {
        active = true,
        config = function()
            require('nvim_comment').setup({
                hook = function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "c" then
                        vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
                    end
                end
            })
        end,
        use = { 'terrortylor/nvim-comment' }
    },
    ['markdown'] = {
        active = true,
        config = function()
        end,
        use = { 'davidgranstrom/nvim-markdown-preview' }
    },
    ['vista'] = {
        active = false,
        config = function()
            vim.cmd [[
            augroup VistaAutoClose
            autocmd!
            autocmd bufenter * if (winnr("$") == 1 && &filetype =~# 'vista') | q | endif
            augroup end
            ]]
            -- vim.cmd [[
            --   function OpenVista()
            --     let cw = win_getid(winnr())
            --     echomsg 'DEBUT'
            --     echomsg cw
            --     Vista
            --     echomsg 'ET PUIS'
            --     echomsg win_getid(winnr())
            --   endfunction
            --   augroup VistaAutoOpen
            --     autocmd!
            --     autocmd BufWinEnter *.c,*.h call OpenVista() 
            --   augroup end
            -- ]]
        end,
        use = { 'liuchengxu/vista.vim' }
    },
    ['symbols-outline'] = {
        active = false,
        config = function()
            require'symbols-outline'.setup()
        end,
        use = { 'simrat39/symbols-outline.nvim' },
    },
    ['wrun'] = {
        active = true,
        config = function()
            require'wrun'.setup({
                cache_dir = os.getenv( "HOME" ) .. '/.local/share/nvim/wrun',
                interpreter = '/usr/bin/bash',
                edit_method = '12split', -- 'edit' | 'tabedit' | 'split'| 'vsplit'
                term_settings = {
                    -- exec_direction = 'float', -- 'vertical' | 'horizontal' | 'float'
                    exec_direction = 'float', -- 'vertical' | 'horizontal' | 'float'
                    size = function(term)
                        if term.direction == "horizontal" then
                            return 15
                        elseif term.direction == "vertical" then
                            return vim.o.columns * 0.4
                        end
                    end, -- or hardcoded value
                    exec_float_opts = {
                        width = 160,
                        height = 50,
                        winblend = 3,
                        highlights = {
                            border = "Normal",
                            background = "Normal",
                        }
                    }
                }
            })
        end,
        use = { 'wombozo/wrun' }
    },
    ['marks'] = {
        active = true,
        config = function()
            require'marks'.setup {
                sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
            }
        end,
        use = { 'chentoast/marks.nvim' }
    },
    ['zoxide'] = {
        active = false,
        config = function()
            require'telescope'.load_extension('zoxide')
            -- local z_utils = require("telescope._extensions.zoxide.utils")
            require("telescope._extensions.zoxide.config").setup(
            {
                prompt_title = "[ Zoxide List ]",

                -- Zoxide list command with score
                list_command = "zoxide query -ls",
                mappings = {
                    default = {
                        action = function(selection)
                            vim.cmd("cd " .. selection.path)
                        end,
                        after_action = function(selection)
                            print("Directory changed to " .. selection.path)
                        end
                    },
                    -- ["<C-s>"] = { action = z_utils.create_basic_command("split") },
                    -- ["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
                    -- ["<C-e>"] = { action = z_utils.create_basic_command("edit") },
                    -- ["<C-b>"] = {
                    --     keepinsert = true,
                    --     action = function(selection)
                    --         builtin.file_browser({ cwd = selection.path })
                    --     end
                    -- },
                    ["<C-f>"] = {
                        keepinsert = true,
                        action = function(selection)
                            builtin.find_files({ cwd = selection.path })
                        end
                    },
                    ["<C-w>"] = {
                        action = function(selection)
                            vim.cmd("cd " .. selection.path)
                        end,
                        after_action = function(_)
                            require'wrun'.run()
                            vim.cmd('cd ' .. os.getenv'HOME')
                        end,
                    }
                }
            })
        end,
        use = { 'jvgrootveld/telescope-zoxide' }
    },
    ['betterescape'] = {
        active = false,
        config = function()
            require("better_escape").setup {
                mapping = {"jk"}, -- a table with mappings to use
                timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
                -- example(recommended)
                -- keys = function()
                --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                -- end,
            }
        end,
        use = { 'max397574/better-escape.nvim' }
    },
    ['hipairs'] = {
        active = false,
        config = function()
            vim.g.hiPairs_jl_matchPair = {term='underline,bold',cterm='underline,bold',ctermfg='0',ctermbg='180',gui='underline,bold',guifg='Black',guibg='#D3B17D'}
        end,
        use = { 'Yggdroot/hiPairs' }
    },
    ['airline'] = {
        active = false,
        config = function()
            vim.cmd[[
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#show_buffers = 1
                let g:airline#extensions#tabline#alt_sep = 1
            ]]
        end,
        -- use = { 'vim-airline/vim-airline', requires = { 'vim-airline/vim-airline-themes' }}
        use = { 'vim-airline/vim-airline',  'vim-airline/vim-airline-themes' },
    },
    ['tabline'] = {
        active = false,
        config = function()
            require'tabline'.setup {
                -- Defaults configuration options
                enable = false,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
                }
            }
            vim.cmd[[
            set guioptions-=e " Use showtabline in gui vim
            set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]]
        end,
        use = {'kdheepak/tabline.nvim'}
    },
    ['lualine'] = {
        active = true,
        config = function()
            require'lualine'.setup {
                options = {
                    theme = 'auto' -- o.line_theme
                }
            }
        end,
        use = { 'hoob3rt/lualine.nvim' }
    },
    ['bufferline'] = {
        active = true,
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = "buffer_id", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    indicator = {
                        style = 'icon',
                        icon = '▎',
                    },
                    buffer_close_icon = '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
                        -- remove extension from markdown files for example
                        if buf.name:match('%.md') then
                            return vim.fn.fnamemodify(buf.name, ':t:r')
                        end
                    end,
                    max_name_length = 18,
                    max_prefix_length = 25, -- prefix used when a buffer is de-duplicated
                    tab_size = 22,
                    diagnostics =  "nvim_lsp", --false | "nvim_lsp" | "coc",
                    diagnostics_update_in_insert = false,
                    diagnostics_indicator = function(count, _, _, _)
                        return "("..count..")"
                    end,
                    -- NOTE: this will be called a lot so don't do any heavy processing here
                    custom_filter = function(buf_number, buf_numbers)
                        -- filter out filetypes you don't want to see
                        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                            return true
                        end
                        -- filter out by buffer name
                        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                            return true
                        end
                        -- filter out based on arbitrary rules
                        -- e.g. filter out vim wiki buffer from tabline in your work repo
                        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                            return true
                        end
                        -- filter out by it's index number in list (don't show first buffer)
                        if buf_numbers[1] ~= buf_number then
                            return true
                        end
                    end,
                    offsets = {{filetype = "NvimTree", text = "File Explorer"}}, -- | function , text_align = "left" | "center" | "right"}},
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    -- show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
                    show_close_icon = false,
                    show_tab_indicators = true,
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style = "thick", -- "slant" | "thick" | "thin" | { 'any', 'any' },
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                    sort_by = 'insert_after_current', --'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                    -- add custom logic
                    --return buffer_a.modified > buffer_b.modified
                    -- end
                },
                highlights = {
                    fill = {
                    },
                    background = {
                    },
                    tab = {
                    },
                    tab_selected = {
                        bg = 'red',
                    },
                }
            }
        end,
        use = { 'akinsho/bufferline.nvim' }
    },
    ['barbar'] = {
        active = false,
        config = function()
        end,
        use = { 'romgrk/barbar.nvim' }
    },
    ['scope'] = {
        active = true,
        config = function()
            require("scope").setup({
                hooks = {
                    pre_tab_enter = function()
                        -- Your custom logic to run before entering a tab
                    end,
                },
            })
        end,
        use = { "tiagovla/scope.nvim" }
    },
    ['neoscroll'] = {
        active = false,
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
                hide_cursor = true,          -- Hide cursor while scrolling
                stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil,       -- Default easing function
                pre_hook = nil,              -- Function to run before the scrolling animation starts
                post_hook = nil,             -- Function to run after the scrolling animation ends
                performance_mode = false,    -- Disable "Performance Mode" on all buffers.
            })
        end,
        use = { 'karb94/neoscroll.nvim' }
    },
    ['persistence'] = {
        active = true,
        config = function()
            require("persisted").setup({
                save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
                command = "VimLeavePre", -- the autocommand for which the session is saved
                use_git_branch = false, -- create session files based on the branch of the git enabled repository
                autosave = false, -- automatically save session files when exiting Neovim
                autoload = false, -- automatically load the session for the cwd on Neovim startup
                allowed_dirs = {
                    "~",
                }, -- table of dirs that the plugin will auto-save and auto-load from
                ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
                follow_cwd = false, -- Doesnt change current session name
                before_save = nil, -- function to run before the session is saved to disk
                -- after_save = function()
                --     print'Session Saved !'
                -- end, -- function to run after the session is saved to disk
                after_source = nil, -- function to run after the session is sourced
                telescope = { -- options for the telescope extension
                before_source = nil, -- function to run before the session is sourced via telescope
                after_source = nil, -- function to run after the session is sourced via telescope
            },
        })
    end,
    use = {-- "folke/persistence.nvim", 
    "olimorris/persisted.nvim"}
    },
    ['indent-blankline']  = {
        active = true,
        config = function()
            require("ibl").setup {
                -- buftype_exclude = { "terminal", "prompt", "nofile" },
                -- filetype_exclude = { "dashboard", "help", "man", "lspinfo", "alpha", "neo-tree", "notify", "noice", "nofile" },
            }
        end,

        use = { 'lukas-reineke/indent-blankline.nvim' },
    },
    ['scrollview'] = {
        active = true,
        config = function()
        end,
        use = { 'dstein64/nvim-scrollview' }
    },
    ['leap'] = {
        active = true,
        config = function()
            require('leap').add_default_mappings()
        end,
        use = { 'ggandor/leap.nvim' }
    },
    ['glow'] = {
        active = true,
        config = function()
        end,
        use = { 'ellisonleao/glow.nvim' }
    },
    ['hlslens'] = {
        active = false,
        config = function()
            require'hlslens'.setup()
        end,
        use = { 'kevinhwang91/nvim-hlslens' }
    },
    ['themes'] = {
        active = true,
        config = function()
            require 'lvim-colorscheme'
        end,
        use =  {
            'NLKNguyen/papercolor-theme',
            'joshdick/onedark.vim',
            'jaredgorski/spacecamp',
            'ayu-theme/ayu-vim',
            'sainnhe/everforest',
            'savq/melange',
            'sjl/badwolf',
            'marciomazza/vim-brogrammer-theme',
            'uu59/vim-herokudoc-theme',
            'srcery-colors/srcery-vim',
            'ciaranm/inkpot',
            'yonlu/omni.vim',
            'lvim-tech/lvim-colorscheme',
            'lancewilhelm/horizon-extended.nvim',
            'catppuccin/nvim'
        }
    },
    ['rust'] = {
        active = true,
        config = function()
        end,
        use = { 'rust-lang/rust.vim' }
    },
    ['taboo'] = {
        active = false,
        config= function()
        end,
        use = { 'gcmt/taboo.vim' }
    },
    ['test'] = {
        active = false,
        config = function()
        end,
        use = { 'ray-x/guihua.lua', 'ray-x/navigator.lua'}
    },
}

local function plugins_get(active)
    for key, value in pairs(plugins) do
        if value.active == active then
            print('----------------')
            print(key .. " :")
            for _, p_use in pairs(value.use) do
                if type(p_use) == "string" then
                    print("\t" .. p_use)
                end
            end
            -- if value.use.requires ~= nil then
                -- print("\t->requires :")
                -- for _, p_use in pairs(value.use.requires) do
                    -- if type(p_use) == "string" then
                        -- print("\t\t" .. p_use)
                    -- end
                -- end
            -- end
        end
    end
end

_G.plugins_get_unused = function()
    plugins_get(false)
end

_G.plugins_get_used = function()
    plugins_get(true)
end

_G.plugins_get_all = function()
    print("===============================================")
    print("USED :")
    plugins_get_used()
    print("===============================================")
    print("UNUSED :")
    plugins_get_unused()
end

local M = { }
M.is_active = function(plugin)
    return plugins[plugin].active
end

local plugs = { }
for _,value in pairs(plugins) do
    if value.active then
        table.insert(plugs, value.use)
    end
end
require'lazy'.setup(plugs)

-- local function packer_startup_func()
--     require'packer'.use'wbthomason/packer.nvim'
--     for _, value in pairs(plugins) do
--         if value.active then
--             require'packer'.use(value.use)
--         end
--     end
-- end

-- require'packer'.startup(packer_startup_func)

for _, value in pairs(plugins) do
    if value.active then
        value.config()
    end
end


return M
