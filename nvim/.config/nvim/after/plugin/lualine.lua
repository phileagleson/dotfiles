require 'lualine'.setup({
  options = {
    theme = 'catpuccin',
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
