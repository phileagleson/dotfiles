local mason_null_ls_status, mason_null_ls = pcall(require, 'mason-null-ls')
local handlers = require 'vim.lsp.handlers'
--local popup = require('plenary.popup')

if not mason_null_ls_status then
  print("Error loading mason-null-ls.. is it installed?")
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(current_client, buffnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set(
    'n', 
    'gr', 
    ':lua require("telescope.builtin").lsp_references({include_current_line=true})<cr>', 
    { buffer = 0, silent = true }
  )
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
  end
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

require 'lspconfig'.emmet_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  --filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'astro' }
}


require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.astro.setup {
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

require 'lspconfig'.svelte.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "rust-analyzer",
  }
}

require 'lspconfig'.luau_lsp.setup {
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

-- local lsp_flags = {
--  debounce_text_changes = 150
-- }
local configs = require "lspconfig.configs"
local util = require 'lspconfig.util'
--local os = vim.loop.os_uname().sysname
local cmd = { "" }
local commonDir = ''
local sysname = os.getenv("SYSNAME")
if (sysname == "archie") then 
  cmd = { "/home/phil/projects/pols/bin/pols" }
  --cmd = { "node", "/mnt/c/Users/peagleson/Desktop/poweron-language-server/out/main.js", "--stdio" }
  require 'lspconfig'.luau_lsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          --globals = { 'vim', 'packer_bootstrap' }
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
  --cmd = { "node", "/home/phil/projects/poweron-language-server/out/main.js", "--stdio" }
  cmd = { "/home/phil/projects/pols/bin/pols" }
  --commonDir = '/home/phil/desktop/poweron/commonFiles/'
end

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

local function handleDataTypeNotification(err,actions,ctx)
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

function handleValidatePoweron(buffnr)
  local symConfigs = {}
  for i in pairs(symConfigurations) do
    symConfigs[i] = symConfigurations[i].name
  end
  uri = "file://".. vim.fn.expand("%:p")
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

function handleInstallPoweron(buffnr)
  local symConfigs = {}
  for i in pairs(symConfigurations) do
    symConfigs[i] = symConfigurations[i].name
  end
  uri = "file://".. vim.fn.expand("%:p")
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

local function on_workspace_exec_command(err, actions, ctx)
  if (ctx.params.command == 'poweronlsp.showDataTypeNotification') then
    handleDataTypeNotification(err, actions, ctx)
  end

  handlers[ctx.method](err, actions, ctx)
end

local function on_publish_diagnostics(err, actions, ctx)
  print("err",vim.inspect(err))
  print("actions",vim.inspect(actions))
  print("ctx",vim.inspect(ctx))
  ctx.result='success'
  handlers[ctx.method](err, actions, ctx)
end

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
    }
  },
}


require 'lspconfig'["poweronls"].setup {
  on_attach = on_attach,
  --flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    symConfigurations = symConfigurations,
  },
}


vim.lsp.set_log_level("debug")

