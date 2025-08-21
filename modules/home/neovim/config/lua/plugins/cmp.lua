local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"nvim-cmp",
		lazy = false,
		after = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

						-- For `mini.snippets` users:
						-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						-- insert({ body = args.body }) -- Insert at cursor
						-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
						-- require("cmp.config").set_onetime({ sources = {} })
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = require "cmp".mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<Tab>'] = cmp.mapping(function(fallback)
						print("test")
						if luasnip.locally_jumpable() then
							luasnip.jump(1)
						elseif not cmp.visible() and has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					['<S-Tab>'] = cmp.mapping.select_prev_item(),
					['<C-e>'] = cmp.mapping.abort(),
					['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip', option = { show_autosnippets = true } },
					{ name = 'vimtex', }
				}, {
					{ name = 'buffer' },
				})
			})
		end
	},
	{
		"cmp-nvim-lsp",
		dep_of = { "nvim-cmp" },
	},
	{
		"cmp_luasnip",
		dep_of = { "nvim-cmp" },
	},
	{
		"cmp-vimtex",
		dep_of = { "nvim-cmp" },
	},
}
