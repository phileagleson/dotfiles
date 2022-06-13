local ok, lualine = pcall('require', 'lualine')
if not ok then
    print('Error loading lualine ')
    return
end

lualine.setup({
    options = {
        theme = 'tokyonight'
    }
})


