local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

-- When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
function M.get_visual(args, parent)
	if (#parent.snippet.env.LS_SELECT_RAW > 0) then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

function M.in_mathzone()
	-- The `in_mathzone` function requires the VimTeX plugin
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return M
