--[[ -- KANAGAWA
require("kanagawa").setup({
  dimInactive = true,
  theme = "dragon",
  --transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        --TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        --TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        --TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        --TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        --TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        --TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end
})

vim.cmd("colorscheme kanagawa") ]]

-- CATPPUCCIN --
require('catppuccin').setup({
  --flavour = "macchiato",
  flavour = "mocha",
  transparent_background = false,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = true,
    telescope=true,
    harpoon=true,
    treesitter=true,
    dap = {
      enabled = true,
      enable_ui = true,
    }
  }
}) 

vim.cmd("colorscheme catppuccin") 

-- ONEDARK
--[[ require('onedark').setup{
  style='darker',
  transparent = true,
}


vim.api.nvim_command 'colorscheme onedark' ]]
--[[ require('material').setup({
  plugins = {
    "dap",
    "gitsigns",
    "indent-blankline",
    "nvim-cmp",
    "nvim-tree",
    "nvim-web-devicons",
    "telescope",
  },
  disable = {
    background = true,
  },
  lualine_style = "stealth",
})

vim.g.material_style = "deep ocean"
vim.api.nvim_command 'colorscheme material' ]]


-- TOKYONIGHT --
--[[ require('tokyonight').setup({

  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})
]]
--vim.cmd [[colorscheme tokyonight]]
--

-- NIGHTFOX --
--[[ require('nightfox').setup({
  options = {
    transparent = true
  }
}) ]]

--vim.cmd [[colorscheme  duskfox]]


-- ONEDARK --
--[[ require('onedark').setup({
  transparent = true,
  style = 'darker',
})]]
--vim.cmd [[colorscheme onedark]] 
