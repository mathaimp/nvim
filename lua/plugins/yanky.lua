vim.pack.add({ "https://github.com/gbprod/yanky.nvim", "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	picker = {
		enabled = true,
	},
})

require("yanky").setup({
	highlight = {
		timer = 150,
	},
})
vim.keymap.set({ "n", "x" }, "y", function()
	return "<Plug>(YankyYank)"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "p", function()
	return "<Plug>(YankyPutAfter)"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "P", function()
	return "<Plug>(YankyPutBefore)"
end, { expr = true })
vim.keymap.set("n", "<C-p>", function()
	return "<Plug>(YankyCycleForward)"
end, { expr = true })
vim.keymap.set("n", "<C-n>", function()
	return "<Plug>(YankyCycleBackward)"
end, { expr = true })

vim.keymap.set("n", "<leader>y", function()
	require("snacks").picker.yanky()
end, {
	desc = "Yank history",
})
