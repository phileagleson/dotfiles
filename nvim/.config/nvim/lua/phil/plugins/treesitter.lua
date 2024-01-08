return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.poweron = {
            install_info = {
                url = "~/projects/tree-sitter-poweron",
                files = { "src/parser.c", "src/scanner.cc" },
                branch = "main",
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = "poweron",
        }

        require("nvim-treesitter.configs").setup({
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
            ensure_installed = "all",
            sync_install = false,
            auto_install = true,
            ignore_install = { "t32", "smali" }
        })
    end,
}
