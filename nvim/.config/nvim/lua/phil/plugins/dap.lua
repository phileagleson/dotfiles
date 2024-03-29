return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "jayp0521/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        vim.keymap.set("n", "<F5>", ':lua require"dap".continue()<cr>')
        vim.keymap.set("n", "<F3>", ':lua require"dap".step_over()<cr>')
        vim.keymap.set("n", "<F2>", ':lua require"dap".step_into()<cr>')
        vim.keymap.set("n", "<F12>", ':lua require"dap".step_out()<cr>')
        vim.keymap.set("n", "<leader>b", ':lua require"dap".toggle_breakpoint()<cr>')
        vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

        require("nvim-dap-virtual-text").setup()
        require("dap-go").setup()
        require("dapui").setup()
        require("mason-nvim-dap").setup({
            automatic_setup = true,
        })

        local dap, dapui = require("dap"), require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        require("mason-nvim-dap").setup({
            ensure_installed = { "node2", "chrome", "delve" },
            automatic_setup = true,
        })

        dap.set_log_level("TRACE")

        dap.adapters.go = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
        dap.configurations.poweron = {
            {
                type = "go",
                name = "Attach to process",
                request = "attach",
                mode = "local",
                processId = require("dap.utils").pick_process,
            },
        }
        -- You NEED to override nvim-dap's default highlight groups, AFTER requiring nvim-dap
        require("dap")

        local sign = vim.fn.sign_define

        sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end,
}
