return {}, {
	s(
		{
			trig = "#",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 100,
		},
		fmta(
			[[ \section*{<>} <> ]],
			{ i(1), i(0), }
		)
	),
	s(
		{
			trig = "##",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 200,
		},
		fmta(
			[[ \subsection*{<>} <> ]],
			{ i(1), i(0), }
		)
	),
	s(
		{
			trig = "###",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 300,
		},
		fmta(
			[[ \subsubsection*{<>} <> ]],
			{ i(1), i(0), }
		)
	),
	s(
		{
			trig = "####",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 400,
		},
		fmta(
			[[ \paragraph*{<>} <> ]],
			{ i(1), i(0), }
		)
	),
	s(
		{
			trig = "#####",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 500,
		},
		fmta(
			[[ \subparagraph*{<>} <> ]],
			{ i(1), i(0), }
		)
	),
}
