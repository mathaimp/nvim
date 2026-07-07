-- Relative numbers only in normal mode
local number_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = number_group,
	callback = function()
		vim.opt.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = number_group,
	callback = function()
		vim.opt.relativenumber = false
	end,
})

-- Auto-save modified buffers when leaving
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent update")
		end
	end,
})

-- Flash yanked text
local yank = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank,
	callback = function()
		vim.hl.on_yank()
	end,
})
