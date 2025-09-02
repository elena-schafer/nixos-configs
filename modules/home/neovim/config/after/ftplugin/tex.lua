-- if we're in a tex file in the notes directory
if vim.fn.expand("$ZK_NOTEBOOK_DIR/latex") == vim.fn.expand("%:p:h") and vim.fn.expand("%:e") == "tex" then
	-- Start continuous compilation
	vim.cmd("VimtexCompileSS")
	-- if nvim rpc server hasn't been started, start it
	if not rpc_started then
		rpc_started = true
		-- Start the nvim rpc server
		vim.fn.serverstart(vim.fn.expand("$HOME/.local/share/nvim/zktex"))
		vim.fn.jobstart("vimtex-layout")
	end
	local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
	local opts = { noremap = true, silent = false }
	map("n", "<leader>zc", "<cmd>ZkNewWithLink<CR>", opts)
	map("n", "<leader>zlc", "<cmd>ZkNewLatexWithLink<CR>", opts)
end
