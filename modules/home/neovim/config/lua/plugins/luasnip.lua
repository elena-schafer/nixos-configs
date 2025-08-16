return {
	{
		"luasnip",
		after = function()
			local ls = require("luasnip")
			ls.setup({
				enable_autosnippets = true,
				update_events = 'TextChanged,TextChangedI'
			})
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
		end,
	},
}
