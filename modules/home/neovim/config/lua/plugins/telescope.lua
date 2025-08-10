return {
	{
		"telescope.nvim",
		keys = {'<leader>ff', '<leader>fg', '<leader>fl', '<leader>fb', '<leader>fh', '<leader>en'},
		after = function()
			local tele = require("telescope")
			tele.setup({})
			tele.load_extension("fzf")
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
			vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			vim.keymap.set("n", "<leader>en", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end)
		end,
	},
}
