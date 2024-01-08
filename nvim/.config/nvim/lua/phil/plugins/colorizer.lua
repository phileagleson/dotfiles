return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require('colorizer').setup {
            '*', -- Higghlight all files, but customize some others
            css = { css = true, },
        }
    end,
}
