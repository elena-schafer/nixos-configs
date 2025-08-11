return {
	{
		"todo-comments.nvim",
		after = function()
			require("todo-comments").setup({})
			--TODO-Comments keybinds
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
			vim.keymap.set('n', '<leader>ft', [[:TodoTelescope<CR>]], {})
		end
	},
}
