local helpers = require('helpers.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local in_mathzone = helpers.in_mathzone


return {}, {
	s({ trig = "bab", dscr = "Expands 'bab' into [a,b] command." },
		fmta("[a,b] ",
			{
			}
		)
	),

}
