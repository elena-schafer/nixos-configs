return {
	{
		"harpoon2",
		-- lazy = false, -- TODO: change to load on keys
		keys = {
			"<Leader>a",
			"<Leader>1",
			"<Leader>2",
			"<Leader>3",
			"<Leader>4",
			"<Leader>5",
			"<Leader>6",
			"<Leader>7",
			"<Leader>8",
			"<Leader>9",
		},
		-- dependencies = { "nvim-lua/plenary.nvim" },
		after = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<Leader>a1", function() harpoon:list():replace_at(1) end)
			vim.keymap.set("n", "<Leader>a2", function() harpoon:list():replace_at(2) end)
			vim.keymap.set("n", "<Leader>a3", function() harpoon:list():replace_at(3) end)
			vim.keymap.set("n", "<Leader>a4", function() harpoon:list():replace_at(4) end)
			vim.keymap.set("n", "<Leader>a5", function() harpoon:list():replace_at(5) end)
			vim.keymap.set("n", "<Leader>a6", function() harpoon:list():replace_at(6) end)
			vim.keymap.set("n", "<Leader>a7", function() harpoon:list():replace_at(7) end)
			vim.keymap.set("n", "<Leader>a8", function() harpoon:list():replace_at(8) end)
			vim.keymap.set("n", "<Leader>a9", function() harpoon:list():replace_at(9) end)

			vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end)
			vim.keymap.set("n", "<Leader>5", function() harpoon:list():select(5) end)
			vim.keymap.set("n", "<Leader>6", function() harpoon:list():select(6) end)
			vim.keymap.set("n", "<Leader>7", function() harpoon:list():select(7) end)
			vim.keymap.set("n", "<Leader>8", function() harpoon:list():select(8) end)
			vim.keymap.set("n", "<Leader>9", function() harpoon:list():select(9) end)
		end,
	},
}
