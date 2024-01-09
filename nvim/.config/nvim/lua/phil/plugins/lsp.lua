local poweron = require("phil.poweron")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(current_client, buffnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references({ include_current_line = true })
    end, { buffer = 0 })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = 0 })
    vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = 0 })
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { buffer = 0 })
    if current_client.name == "poweronls" then
        vim.keymap.set("n", "<F7>", function()
            poweron.handleValidatePoweron(buffnr)
        end, { buffer = 0, silent = true })
        vim.keymap.set("n", "<F8>", function()
            poweron.handleInstallPoweron(buffnr)
        end, { buffer = 0, silent = true })

        vim.api.nvim_buf_create_user_command(buffnr, "PoweronDeploy", function()
            poweron.handleDeployPoweron(buffnr)
        end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronInstall", function()
            poweron.handleInstallPoweron(buffnr)
        end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronValidate", function()
            poweron.handleValidatePoweron(buffnr)
        end, {})
        vim.api.nvim_buf_create_user_command(buffnr, "PoweronImport", function()
            poweron.getPoweronList(buffnr)
        end, {})
    end
end

local handlers = require("vim.lsp.handlers")
local function on_workspace_exec_command(err, actions, ctx)
    if ctx.params.command == "poweron.showDataTypeNotification" then
        poweron.handleDataTypeNotification(err, actions, ctx)
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
                        server_uninstalled = "✗",
                    },
                },
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
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = {
                                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                            [vim.fn.stdpath("config") .. "/lua"] = true,
                                        },
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                        })
                    end,
                    ["emmet_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.emmet_ls.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            filetypes = {
                                "html",
                                "css",
                                "scss",
                                "javascript",
                                "javascriptreact",
                                "typescript",
                                "typescriptreact",
                                "svelte",
                                "vue",
                                "twig",
                                "blade",
                                "poweron",
                            },
                        })
                    end,
                },
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
                        ["workspace/executeCommand"] = on_workspace_exec_command,
                        ["window/showMessage"] = on_show_message,
                    },
                },
            }

            require("lspconfig")["poweronls"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    symConfigurations = poweron.symConfigurations,
                },
            })
        end,
    },
    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        config = function()
            require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
        end,
    },
}
