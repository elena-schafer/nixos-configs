local helpers = require('helpers.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local in_mathzone = helpers.in_mathzone


return {}, {
	s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta(
			[[\href{<>}{<>} <>]],
			{
				i(1, "url"),
				i(2, "display name"),
				i(0),
			}
		)
	),
	s({ trig = "bb", dscr = "Blackboard bold" },
		fmta(
			[[\mathbb{<>} <>]],
			{
				i(1, "Letter"),
				i(0),
			}
		)
	),
	s({ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
		fmta("\\textit{<>} ",
			{
				d(1, get_visual),
			}
		)
	),

}
