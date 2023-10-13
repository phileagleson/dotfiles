require 'lualine'.setup({
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
