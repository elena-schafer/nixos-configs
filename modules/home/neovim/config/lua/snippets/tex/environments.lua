local function tableContains(table, values)
	local contains = false
	for i, entry in ipairs(table) do
		for j, val in ipairs(values) do
			if entry == val then
				contains = true
			end
		end
	end
	return contains
end

return {}, {
	s(
		{
			trig = "mm",
			dscr = "inline math",
			regTrig = false,
			wordTrig = true,
			priority = 100,
		},
		fmta(
			[[
				$<>$<><>
			]],
			{
				i(1),
				f(function(argnode_text, parent)
					vim.print(argnode_text)
					if tableContains(argnode_text, { ',', '.', '?', '-', ' ' }) then
						return ''
					else
						return ' '
					end
				end, { 2 }),
				i(2),
			}
		)
	),

	s(
		{
			trig = "ee",
			dscr = "equation environment",
			regTrig = false,
			wordTrig = true,
			priority = 100,
		},
		fmta(
			[[
				\begin{equation*}
					<>
				\end{equation*}
				<>
			]],
			{
				i(1),
				i(0),
			}
		)
	),

	s(
		{
			trig = "aa",
			dscr = "align environment",
			regTrig = false,
			wordTrig = true,
			priority = 100,
		},
		fmta(
			[[
				\begin{align*}
					<>
				\end{align*}
				<>
			]],
			{
				i(1),
				i(0),
			}
		)
	),

	s(
		{
			trig = "beg",
			dscr = "general environment snippet",
			regTrig = false,
			wordTrig = true,
			priority = 100,
		},
		fmta(
			[[
				\begin{<>}
					<>
				\end{<>}
				<>
			]],
			{
				i(1),
				i(2),
				rep(1),
				i(0),
			}
		)
	),
}
