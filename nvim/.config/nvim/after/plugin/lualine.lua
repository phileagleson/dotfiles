require 'lualine'.setup({
  options = {
    theme = 'catppuccin'
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
