require 'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  ensure_installed = 'all',
  sync_install = false,
  ignore_install = { '' },
  highlight = {
    enable = true
  },
  autopairs = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>ts',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.poweron = {
  install_info = {
    url = '~/projects/tree-sitter-poweron',
    files = { "src/parser.c", "src/scanner.cc" },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
  filetype = 'poweron'
}

require('treesitter-context').setup {
  patterns = {
    poweron = {
      'procedure_definition',
      'if_statement',
      'define_division',
      'setup_division',
      'print_division',
      'for_loop',
    },
  },
}
