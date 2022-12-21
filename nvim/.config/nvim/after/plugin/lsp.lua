local mason_null_ls_status, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_status then
  print("Error loading mason-null-ls.. is it installed?")
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set('n', '<leader>rr', '<cmd>Telescope lsp_references<CR>', { buffer = 0 })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', { buffer = 0 })
end

-- must setup in order
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- 3. lspconfig
--
require 'mason'.setup({
  max_concurrent_installers = 4,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

require 'mason-lspconfig'.setup {
  ensure_installed = {},
  automatic_installation = false,
}
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
mason_null_ls.setup {
  ensure_installed = {},
  on_attach = function(current_client, bufnr)
    if current_client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              -- only use null-ls for formatting instead fo lsp server
              return client.name == 'null-ls'
            end,
            buffnr = bufnr,
          })
        end,
      })
    end
  end
}
require 'lspconfig'.emmet_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

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
local commonDir = ''
if os == "Darwin" then
  cmd = { "node", "/Users/phil/projects/tspoweronlsp/server/out/server.js", "--stdio" }
  commonDir = '/Users/phil/projects/poweron/RDFILES'
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
else
  cmd = { "node", "/home/phil/desktop/poweron-language-server/out/main.js", "--stdio" }
  --commonDir = '/home/phil/desktop/poweron/commonFiles/'
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
  --flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    commonFilesDirectory = commonDir
  },
}

--vim.lsp.set_log_level("info")
local setup, null_ls = pcall(require, 'null-ls')
if not setup then
  return
end

-- local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {}
}