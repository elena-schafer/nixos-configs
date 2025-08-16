local helpers = require('helpers.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local in_mathzone = helpers.in_mathzone


return {}, {
	s({ trig = "--", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta(
			[[- [ ] <> ]],
			{
				i(0),
			}
		)
	),
}
