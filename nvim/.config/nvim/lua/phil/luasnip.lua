if vim.g.snippets == "luasnip" then
    return
end

local ls = require 'luasnip'
--local types = require "luasnip.util.types"

ls.config.set_config {
    -- This tells Luasnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- this on is cool cause if you have dynamic snippets, it updates as you types
    updateevents = "TextChanged, TextChangedI",

    -- Autosnippets
    enable_autosnippets = true,
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

--require('luasnip.loaders.from_lua').lazy_load({ paths = "~/.config/nvim/lua/phil/luasnip/snippets" })
