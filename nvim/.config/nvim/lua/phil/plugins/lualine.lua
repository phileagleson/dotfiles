return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"barklan/capslock.nvim",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
				icons_enabled = true,
			},
			sections = {
				lualine_x = {
					{ require("capslock").status_string },
				},
			},
		})
	end,
}
