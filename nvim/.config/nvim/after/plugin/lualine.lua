require 'lualine'.setup({
  options = {
    theme = 'tokyonight'
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
