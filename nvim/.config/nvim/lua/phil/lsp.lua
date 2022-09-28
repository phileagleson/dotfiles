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

--[[ require 'lspconfig'.cssls {
    capabilities = capabilities,
    on_attach = on_attach,
} ]]


require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'packer_bootstrap' }
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
local lsp_flags = {
    debounce_text_changes = 150
}
local configs = require "lspconfig.configs"
local util = require 'lspconfig.util'
local os = vim.loop.os_uname().sysname
local cmd = { "" }
if os == "Darwin" then
    cmd = { "/Users/phil/projects/poweronls/poweronls" }
else
    cmd = { "/home/phil/projects/poweronls/poweronls" }
end


configs["poweronls"] = {
    default_config = {
        cmd = cmd,
        root_dir = util.find_git_ancestor,
        filetypes = { "poweron" },
        autostart = true
    },
}

require 'lspconfig'["poweronls"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

vim.lsp.set_log_level("debug")

-- show diagnostics in hover window
--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus=false, scope="cursor"})]]
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--     buffer = bufnr,
--     callback = function()
--         local opts = {
--             --            focusable = false,
--             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--             focus = false,
--             border = 'rounded',
--             source = 'always',
--             prefix = ' ',
--             scope = 'cursor',
--         }
--         vim.diagnostic.open_float(nil, opts)
--     end
-- })

vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })<cr>')
