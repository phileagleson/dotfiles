local symConfigurations = {
    {
        name = "SMOPROSVS-SYM700",
        symNumber = "700",
        hostname = "https://smoprosvs.jhacorp.com",
        port = "42700",
        aixUserName = "peagleson",
        aixPassword = os.getenv("SMOPROSVS_PASS"),
        symUserNumber = "0",
        symPassword = "0",
        device = os.getenv("HOSTNAME"),
        deviceIp = os.getenv("HOSTIP"),
    },
    {
        name = "SMOEPIPVC94-SYM777",
        symNumber = "777",
        hostname = "https://smoepipvc94.jhacorp.com",
        port = "42777",
        aixUserName = "peagleso",
        aixPassword = os.getenv("SMOPROSVS_PASS"),
        symUserNumber = "0",
        symPassword = "Symitar#2",
        device = os.getenv("HOSTNAME"),
        deviceIp = os.getenv("HOSTIP"),
    },
}

local function handleValidatePoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Validate PowerOn - Choose Sym"
    }, function(choice)
        if (choice) then
            vim.lsp.buf_request(buffnr, 'workspace/executeCommand', {
                command = 'lsp.validatePoweron',
                arguments = {
                    {
                        symConfigName = choice,
                        uri = uri,
                    },
                }
            }, nil)
        end
    end)
end

local function handleInstallPoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Install PowerOn - Choose Sym"
    }, function(choice)
        if (choice) then
            vim.lsp.buf_request(buffnr, 'workspace/executeCommand', {
                command = 'lsp.installPoweron',
                arguments = {
                    {
                        symConfigName = choice,
                        uri = uri,
                    },
                }
            }, nil)
        end
    end)
end

local function handleDeployPoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    local opts = {
        require("telescope.themes").get_dropdown {},
        title = "Choose Sym(s)",
    }
    My_custom_picker(opts, symConfigs, function(results)
        local selected = {}
        for _, res in ipairs(results) do
            for _, item in ipairs(res) do
                table.insert(selected, item)
            end
        end

        if (#selected == 0) then
            return
        end

        vim.lsp.buf_request(buffnr, 'workspace/executeCommand', {
            command = 'lsp.deployPoweron',
            arguments = {
                {
                    deployToSyms = selected,
                    uri = uri,
                },
            }
        }, nil)
    end)
end

local function selectPoweron(poweronList, symConfigName)
    local opts = {
        require("telescope.themes").get_dropdown {},
        title = "Choose Poweron(s)",
    }

    My_custom_picker(opts, poweronList, function(results)
        local selected = {}
        for _, res in ipairs(results) do
            for _, item in ipairs(res) do
                table.insert(selected, item)
            end
        end

        if (#selected == 0) then
            return
        end

        vim.lsp.buf_request(0, 'workspace/executeCommand', {
            command = 'lsp.importPowerons',
            arguments = {
                {
                    symConfigName = symConfigName,
                    poweronList = selected
                }
            }
        })
    end)
end

local function getPoweronList(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Import PowerOn - Choose Sym"
    }, function(configChoice)
        if (configChoice) then
            vim.ui.input({ prompt = "Search (*=any string, ?=any char):" }, function(searchString)
                vim.lsp.buf_request(buffnr, 'workspace/executeCommand', {
                    command = 'lsp.getPoweronList',
                    arguments = {
                        {
                            searchFilter = searchString,
                            symConfigName = configChoice,
                        }
                    }
                }, function(err, res, _)
                    if (err) then
                        vim.notify(err.message, vim.log.levels.ERROR)
                        return
                    end
                    local poweronList = res["TaskManager_PowerOnList"]["poweronList"]
                    if (poweronList == nil) then
                        vim.notify("No PowerOn found", vim.log.levels.ERROR)
                        return
                    end
                    selectPoweron(poweronList, configChoice)
                end)
            end)
        end
    end)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(current_client, buffnr)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set('n', 'gr',
        function() require("telescope.builtin").lsp_references({ include_current_line = true }) end,
        { buffer = 0 })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', { buffer = 0 })
    vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_workspace_symbols<cr>', { buffer = 0 })
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', { buffer = 0 })
    vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { buffer = 0 })
    if (current_client.name == 'poweronls') then
        vim.keymap.set('n', '<F7>', function() handleValidatePoweron(buffnr) end, { buffer = 0, silent = true })
        vim.keymap.set('n', '<F8>', function() handleInstallPoweron(buffnr) end, { buffer = 0, silent = true })

        vim.api.nvim_buf_create_user_command(buffnr, "PoweronDeploy", function() handleDeployPoweron(buffnr) end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronInstall", function() handleInstallPoweron(buffnr) end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronValidate", function() handleValidatePoweron(buffnr) end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronImport", function() getPoweronList(buffnr) end, {})
    end
end

local function handleDataTypeNotification(_, _, ctx)
    local uri     = ctx['params']['arguments'][1]['uri']
    local varName = ctx['params']['arguments'][1]['varName']
    local bufnr   = ctx.bufnr
    vim.ui.select({
        "CHARACTER",
        "CODE",
        "DATE",
        "FLOAT",
        "MONEY",
        "NUMBER",
        "RATE"
    }, {
        prompt = "Choose Data type"
    }, function(choice)
        if (choice) then
            vim.lsp.buf_request(bufnr, 'workspace/executeCommand', {
                command = 'lsp.addVarToDefine',
                arguments = {
                    {
                        dataType = choice,
                        varName = varName,
                        uri = uri,
                    },
                },
            }, nil)
        end
    end)
end

local handlers = require 'vim.lsp.handlers'
local function on_workspace_exec_command(err, actions, ctx)
    if (ctx.params.command == 'poweron.showDataTypeNotification') then
        handleDataTypeNotification(err, actions, ctx)
    end

    handlers[ctx.method](err, actions, ctx)
end

local function on_show_message(_, actions, _)
    local severity = {
        "error",
        "warn",
        "info",
        "info",
    }
    vim.notify(actions.message, severity[actions.type])
end


return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup({
                max_concurrent_installers = 4,
                ui = {
                    icons = {
                        server_installed = "✓",
                        server_pending = "➜",
                        server_uninstalled = "✗"
                    }
                }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "tsserver",
                },
                automatic_installation = true,
                handlers = {

                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                        })
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    },
                                    workspace = {
                                        library = {
                                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                            [vim.fn.stdpath "config" .. "/lua"] = true,
                                        },
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                }
                            }
                        })
                    end,
                    ["emmet_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.emmet_ls.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue", "twig", "blade", "poweron" },
                        })
                    end,
                }
            })

            local configs = require("lspconfig.configs")
            local cmd = { "/home/phil/projects/pols/bin/pols" }
            configs["poweronls"] = {
                default_config = {
                    cmd = cmd,
                    root_dir = function()
                        return vim.loop.cwd()
                    end,
                    filetypes = { "poweron" },
                    autostart = true,
                    handlers = {
                        ['workspace/executeCommand'] = on_workspace_exec_command,
                        ['window/showMessage'] = on_show_message,
                    }
                },
            }

            require 'lspconfig'["poweronls"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    symConfigurations = symConfigurations,
                },
            }
        end,
    },
    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        config = function()
            require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
        end,
    },
}
