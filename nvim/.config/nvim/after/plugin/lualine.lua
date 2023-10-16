require 'lualine'.setup({
  options = {
    theme = 'kanagawa',
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
