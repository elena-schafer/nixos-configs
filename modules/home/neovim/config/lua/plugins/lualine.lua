return {
	{
		"lualine.nvim",
		after = function()
			require("lualine").setup({ options = { theme = "catppuccin" } })
		end
	},
}
