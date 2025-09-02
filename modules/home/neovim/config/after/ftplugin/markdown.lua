-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
	-- local zk = require("zk")

	--
	local function findLink(pos, text, delimiters)
		local start = 1
		local ending = #text
		-- search forwards until we reach delimiter or end of line
		for idx = pos, #text - 1 do
			local delim = string.byte("]")
			if text:byte(idex) == delim and text:byte(idx + 1) == delim then
				ending = idx + 1
			end
		end
		-- search backwards until we reach whitespace or beginning of line
		for idx = pos, 2, -1 do
			local test = false
			local delim = string.byte("[")
			if text:byte(idx) == delim and text:byte(idx - 1) == delim then
				start = idx - 1
			end
		end
		-- return the found range of the string
		return text:sub(start, ending)
	end

	local function findNoteInfo(text)
		local middle = 1
		local ending = #text - 2
		local delim1 = string.byte("/")
		local delim2 = string.byte("|")
		for idx = 3, #text - 2 do
			if text:byte(idx) == delim1 then
				middle = idx
			end
			if text:byte(idx) == delim2 then
				ending = idx - 1
			end
		end
		-- return the found ranges of the string
		return { first = text:sub(3, middle - 1), last = text:sub(middle + 1, ending) }
	end

	-- follows the wiki link under the cursor
	-- includes special addon for following to latex notes
	local function follow_link()
		local pos = vim.fn.getpos(".")
		local line = vim.fn.getline(pos[2])
		local token = findLink(pos[3], line)
		local info = findNoteInfo(token)
		if info.first == "latex" then
			vim.cmd("e $ZK_NOTEBOOK_DIR/latex/" .. info.last .. ".tex")
		else
			vim.lsp.buf.definition()
		end
	end

	-- Zero here means current buffer
	local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
	local opts = { noremap = true, silent = false }


	-- Open the link under the caret.
	map("n", "<CR>", "", { callback = follow_link, noremap = true, silent = false })

	-- Create a new note after asking for its title, and insert a link to it at current cursor location.
	map("n", "<leader>zc", "<cmd>ZkNewWithLink<CR>", opts)
	map("n", "<leader>zlc", "<cmd>ZkNewLatexWithLink<CR>", opts)

	-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
	-- map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

	-- Open notes linking to the current buffer.
	map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
	-- Alternative for backlinks using pure LSP and showing the source context.
	--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- Open notes linked by the current buffer.
	map("n", "<leader>zll", "<Cmd>ZkLinks<CR>", opts)

	-- Preview a linked note.
	map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

	map("n", "<leader>za", "<Cmd>ZkAddLink<CR>", opts)
	map("n", "<leader>zx", "<Cmd>MDTaskToggle<CR>", opts)

	-- Jump to next link?
end
