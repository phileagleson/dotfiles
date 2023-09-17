require 'lualine'.setup({
  options = {
    theme = 'material'
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
