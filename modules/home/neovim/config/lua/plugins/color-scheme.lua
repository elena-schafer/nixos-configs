return {
	{
		"catppuccin-nvim",
		lazy = false,
		--colorscheme = "catppuccin",
		after = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
		end,
	},
	{
		"transparent.nvim",
		lazy = false,
		after = function()
			vim.cmd.TransparentEnable()
		end
	},
}
