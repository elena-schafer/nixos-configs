return {
	{
		"zk-nvim",
		lazy = false,
		after = function()
			local zk = require("zk")
			local api = require("zk.api")
			local commands = require("zk.commands")
			local util = require("zk.util")

			zk.setup({
				picker = "telescope",
			})


			-- Custom command to create new note and insert a wiki link with the title of the note
			commands.add("ZkNewWithLink", function(options)
				-- more properly we should use the options param to make the function reusable, but idc
				local title = vim.fn.input('Title: ')
				options = vim.tbl_extend("force", { title = title }, options or {})
				api.new(options.notebook_path, options, function(err, res)
					assert(not err, tostring(err))
					local path = vim.fs.basename(res.path) -- remove path to notebook
					local noteID = path:sub(0, -4)
					local link = "[[" .. noteID .. "|" .. title .. "]]"
					local pos = vim.api.nvim_win_get_cursor(0)[2]
					local line = vim.api.nvim_get_current_line()
					local nline = line:sub(0, pos) .. link .. line:sub(pos + 1)
					vim.api.nvim_set_current_line(nline)
					vim.cmd("edit " .. res.path)
				end)
			end)

			-- Custom command to insert a wiki link with the title of the note
			commands.add("ZkAddLink", function(options)
				-- more properly we should use the options param to make the function reusable, but idc
				options = options or {}
				zk.pick_notes(options.notebook_path, options, function(res)
					-- Multi_select is enabled, should probably process them all, but only doing the first one
					local title = res[1].title
					local path = vim.fs.basename(res[1].path)
					local noteID = path:sub(0, -4)
					local link = "[[" .. noteID .. "|" .. title .. "]]"
					local pos = vim.api.nvim_win_get_cursor(0)[2]
					local line = vim.api.nvim_get_current_line()
					local nline = line:sub(0, pos) .. link .. line:sub(pos + 1)
					vim.api.nvim_set_current_line(nline)
				end)
			end)

			-- Custom command to sync notes with github
			commands.add("ZkSync", function(options)
				commitMessage = "Commit at" .. vim.fn.strftime('%d %b %Y %H:%M:%S %p')
				vim.api.nvim_command('tabnew | term')
				vim.api.nvim_input('i cd /home/elena/notes ; git add -A ; git commit -m "' ..
					commitMessage ..
					'" ; git fetch ; git merge origin/main -s ort -Xours -m "Merge remote-tracking branch origin/main" ; git push\n')
			end)

			-- Command example from zk-nvim that lists orphan notes
			commands.add("ZkOrphans", function(options)
				options = vim.tbl_extend("force", { orphan = true }, options or {})
				zk.edit(options, { title = "Zk Orphans" })
			end)

			-- note more keybinds can be found in the file type plugin for markdown
			local opts = { noremap = true, silent = false }

			-- Open index
			vim.keymap.set("n", "<leader>zi", "<cmd>e ~/notes/index.md<CR>", opts)
			-- Open quick note
			vim.keymap.set("n", "<leader>zq", "<cmd>e ~/notes/quicknote.md<CR>", opts)
			-- Open todo note
			vim.keymap.set("n", "<leader>zt", "<cmd>e ~/notes/todo.md<CR>", opts)

			-- Open today's daily
			vim.api.nvim_set_keymap("n", "<leader>zd", "<cmd>ZkNew { dir = \"daily\" }<CR>", opts)
			-- Search daily notes

			-- Sync notes with github
			vim.api.nvim_set_keymap("n", "<leader>zr", "<cmd>ZkSync<CR>", opts)



			-- Open notes.
			vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

			-- Open orphan notes
			vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkOrphans<CR>", opts)

			-- Open notes associated with the selected tags.
			-- vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)
		end,
	},
	{
		'render-markdown.nvim',
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		ft = "markdown",
		after = function()
			require('render-markdown').setup({
				latex = {
					enabled = false,
				},
			})
		end
	},
	{
		"markdown.nvim",
		ft = "markdown",
		after = function()
			require('markdown').setup({
				mappings = false
			})
		end
	},
}
