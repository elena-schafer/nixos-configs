-- if we're in a tex file in the notes directory
if vim.fn.expand("$ZK_NOTEBOOK_DIR/latex") == vim.fn.expand("%:p:h") then
	-- Start continuous compilation
	vim.cmd("VimtexCompileSS")
	-- if nvim rpc server hasn't been started, start it
	if not rpc_started then
		rpc_started = true
		-- Start the nvim rpc server
		vim.fn.serverstart(vim.fn.expand("$HOME/.local/share/nvim/zktex"))
		vim.fn.jobstart("vimtex-layout")
	end
end
