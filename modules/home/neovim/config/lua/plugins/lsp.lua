return {
	{
		"nvim-lspconfig",
		after = function()
			vim.lsp.enable('lua_ls')
			vim.lsp.config('nixd', {
				settings = {
					formatting = {
						command = { "nixfmt" },
					},
				},
			})
			vim.lsp.enable('nixd')
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end
					if client.supports_method("textDocument/formatting") then
						-- Before write format the file
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end
						})
					end
					vim.keymap.set("n", "grn", vim.lsp.buf.rename)
					vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
					vim.keymap.set("n", "grr", vim.lsp.buf.references)
					vim.keymap.set("n", "gri", vim.lsp.buf.implementation)
					vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
				end
			})
		end
	},

	-- ?
	-- {
	-- 	"mason-lspconfig.nvim",
	-- 	opts = {
	-- 		ensure_installed = { "lua_ls", },
	-- 	},
	-- 	dependencies = {
	-- 		{ "williamboman/mason.nvim", opts = {}},
	-- 		{ "neovim/nvim-lspconfig" },
	-- 		{
	-- 			"folke/lazydev.nvim",
	-- 			ft = "lua",
	-- 			opts = {
	-- 				library = {
	-- 					{ path = "${3rd}/luv/library", works = { "vim%.uv" } }
	-- 				}
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function(plugin, opts)
	-- 		require("mason-lspconfig").setup({
	-- 			ensure_installed = { "lua_ls", },
	-- 		})

	-- 		-- Add autocommands and keybinds when lsp attaches to buffer
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			callback = function(args)
	-- 				local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 				if not client then return end
	-- 				if client.supports_method("textDocument/formatting") then
	-- 					-- Before write format the file
	-- 					vim.api.nvim_create_autocmd("BufWritePre", {
	-- 						buffer = args.buf,
	-- 						callback = function()
	-- 							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
	-- 						end
	-- 					})
	-- 				end
	-- 				vim.keymap.set("n", "grn", vim.lsp.buf.rename)
	-- 				vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
	-- 				vim.keymap.set("n", "grr", vim.lsp.buf.references)
	-- 				vim.keymap.set("n", "gri", vim.lsp.buf.implementation)
	-- 				vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
	-- 			end
	-- 		})
	-- 	end
	-- },
}
