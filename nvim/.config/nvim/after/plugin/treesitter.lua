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

require 'nvim-treesitter.configs'.setup {
 indent = {
  enable = true
 },
 ensure_installed = 'all',
 sync_install = false,
 ignore_install = { 'smali','t32' },
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
   init_selection = '<c-space>',
   node_incremental = '<c-space>',
   scope_incremental = '<c-s>',
   node_decremental = '<c-backspace>',
  },
 },
 textobjects = {
  select = {
   enable = true,
   lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
   keymaps = {
    -- You can use the capture groups defined in textobjects.scm
    ['aa'] = '@parameter.outer',
    ['ia'] = '@parameter.inner',
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['ac'] = '@class.outer',
    ['ic'] = '@class.inner',
   },
  },
  move = {
   enable = true,
   set_jumps = true, -- whether to set jumps in the jumplist
   goto_next_start = {
    [']m'] = '@function.outer',
    [']]'] = '@class.outer',
   },
   goto_next_end = {
    [']M'] = '@function.outer',
    [']['] = '@class.outer',
   },
   goto_previous_start = {
    ['[m'] = '@function.outer',
    ['[['] = '@class.outer',
   },
   goto_previous_end = {
    ['[M'] = '@function.outer',
    ['[]'] = '@class.outer',
   },
  },
  --[[ swap = {
   enable = false,
   swap_next = {
    ['<leader>a'] = '@parameter.inner',
   },
   swap_previous = {
    ['<leader>A'] = '@parameter.inner',
   },
  }, ]]
 },
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
