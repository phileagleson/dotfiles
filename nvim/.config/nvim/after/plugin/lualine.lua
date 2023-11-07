require 'lualine'.setup({
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
  },
  sections = {
    lualine_x = {
      { require('capslock').status_string },
    },
  },
})
