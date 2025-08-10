return {
	{
		"nvim-treesitter",
		lazy = false,
		priority = 100,
		after = function()
			require('nvim-treesitter.configs').setup({
				-- ensure_installed = { "c", "lua", "bash", "java", "json5", "python", "sql", "vim", "vimdoc", },
				auto_install = false,
				highlight = { enable = true, disable = { "latex" } }, --latex exception is needed for certain vimtex features to work
				incremental_selection = { enable = true, },
				indent = { enable = true, },
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						},
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
				},
			})
		end
	},
	{
		-- needed for textobject motions to work
		"nvim-treesitter-textobjects",
		lazy = false,
		priority = 50,
	},
}
