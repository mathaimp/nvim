vim.pack.add({
	"https://github.com/shaunsingh/nord.nvim",
})

vim.cmd.colorscheme("nord")

-- Transparent backgrounds
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

require("plugins.status")
