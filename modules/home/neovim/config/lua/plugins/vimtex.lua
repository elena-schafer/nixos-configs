return {
	{
		"vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		before = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura_simple"
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_quickfix_ignore_filters = { 'Underfull \\hbox', 'Overfull \\hbox', }
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = function(file_info)
					-- Send auxiliary file to /tmp, to avoid us having to manually do cleanup
					notes = vim.fn.expand("$HOME/notes/latex")
					if (file_info.root == notes) then
						return "/tmp/latex_notes_aux"
					end
					return file_info.root
				end,
			}
		end
	},
}
