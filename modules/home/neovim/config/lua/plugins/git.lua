return {
	{
		"gitsigns.nvim",
		lazy = false,
		after = function()
			-- docs say this isn't necessary, but it won't work without it for me
			require("gitsigns").setup({})
		end
	},
}
