return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            enabled = vim.fn.executable("make") == 1,
        },
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            pickers = {
                neovim_lsp = {
                    include_current_line = true,
                },
            },
        })

        require("telescope").load_extension("fzf")
        vim.keymap.set(
            "n",
            "<leader>?",
            require("telescope.builtin").oldfiles,
            { desc = "[?] Find recently opened files" }
        )
        vim.keymap.set(
            "n",
            "<leader><space>",
            require("telescope.builtin").buffers,
            { desc = "[ ] Find existing buffers" }
        )
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer]" })

--        vim.keymap.del("n", "<C-H>", {})
        vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>st", "<cmd>Telescope git_files<cr>", { desc = "[S]earch Gi[t]" })
        vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set(
            "n",
            "<leader>sw",
            require("telescope.builtin").grep_string,
            { desc = "[S]earch current [W]ord" }
        )

        require("telescope").load_extension("ui-select")

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        --local action_utils = require("telescope.actions.utils")
        local action_state = require("telescope.actions.state")

        My_custom_picker = function(opts, items, callback)
            opts = opts or {}
            pickers
                .new(opts, {
                    prompt_title = opts.title,
                    finder = finders.new_table({
                        results = items,
                    }),
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(prompt_bufnr, _)
                        actions.select_default:replace(function()
                            local results = {}
                            local current = action_state.get_current_picker(prompt_bufnr)
                            for _, item in ipairs(current:get_multi_selection()) do
                                table.insert(results, item)
                            end
                            actions.close(prompt_bufnr)
                            callback(results)
                        end)
                        return true
                    end,
                })
                :find()
        end
    end,
}
