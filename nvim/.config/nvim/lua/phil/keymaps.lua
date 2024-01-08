vim.keymap.del("n", "<C-H>")
vim.keymap.set("n", "<C-H>", ":<C-U>TmuxNavigateLeft<cr>", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- Navigate Quick fix list
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")

-- keep copied item
vim.keymap.set("v", "p", '"_dP')

-- stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Tmux nav --
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set({ "n", "v" }, "<leader>q", "<cmd>silent !jqpaste<CR>P:%!jq .<CR>")

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>cd", "<cmd>:cd %:h<cr>", nil) -- change to dir of current open file

vim.api.nvim_set_keymap(
	"v",
	"<Leader>y",
	[[:lua YankMatchesToRegister('a', vim.fn.line("'<"), vim.fn.line("'>"))<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<Leader>p", ':lua vim.cmd("normal! \\"ap")<CR>', { noremap = true, silent = true })

function YankMatchesToRegister(register, start_line, end_line)
	local result = {}

	for line = start_line, end_line do
		local text = vim.fn.getline(line)
		local match = text:match('"([^"]+)"')
		if match then
			table.insert(result, match)
		end
	end
	vim.fn.setreg(register, table.concat(result, "\n"))
end
