vim.pack.add({
	"https://github.com/gbprod/nord.nvim",
})

vim.cmd.colorscheme("nord")

-- Transparent backgrounds
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- status.lua reads highlight colors; nord is applied above so colors are
-- correct, but defer the require itself off the startup critical path.
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			require("plugins.status")
		end)
	end,
})
