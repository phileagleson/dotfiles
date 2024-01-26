return {
    "vimwiki/vimwiki",
    init = function()
        vim.g.vimwiki_list = {
            {
                path = "~/vimwiki",
                syntax = "markdown",
                ext = ".md",
            },
        }
    end,
    config = function()
        vim.keymap.set("n", "<leader><CR>", vim.cmd.VimwikiVSplitLink)
    end,
    --<Plug>VimwikiVSplitLink
}
