-- File is for dependencies of multiple plugins
-- when a dependency is only for one plugin it should be included in same file as plugin
return {
	{
		"plenary.nvim",
		dep_of = { "telescope.nvim", "harpoon2", "todo-comments.nvim", },
	},
}
