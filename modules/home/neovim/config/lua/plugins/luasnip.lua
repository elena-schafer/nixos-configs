return {
	{
		"luasnip",
		lazy = false,
		priority = 100,
		after = function()
			local ls = require("luasnip")
			ls.setup({
				enable_autosnippets = true,
				update_events = 'TextChanged,TextChangedI'
			})
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
		end,
		dep_of = { "nvim-cmp", "cmp_luasnip", },
	},
}
