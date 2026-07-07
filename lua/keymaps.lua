-- Keymaps
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>", { desc = "Alternate buffer" })

-- vim.pack
vim.keymap.set("n", "<leader>pu", function()
	vim.pack.update()
end, { desc = "Update plugins" })

vim.keymap.set("n", "<leader>pr", function()
	local plugins = vim.pack.get()
	local names = {}

	for _, plugin in ipairs(plugins) do
		table.insert(names, plugin.spec.name)
	end

	vim.ui.select(names, { prompt = "Remove plugin: " }, function(choice)
		if choice then
			vim.pack.del({ choice })
		end
	end)
end, { desc = "Remove plugin" })
