local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0 })
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', { buffer = 0 })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
end

require 'nvim-lsp-installer'.setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

require 'lspconfig'.emmet_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}


require 'lspconfig'.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}


require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
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
}
