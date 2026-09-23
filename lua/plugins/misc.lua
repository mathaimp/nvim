vim.pack.add({
	{ src = "https://github.com/lervag/vimtex" },
})

vim.g.vimtex_compiler_method = "tectonic"

vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "evince"

vim.g.vimtex_quickfix_open_on_warning = 0

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	callback = function()
		vim.cmd("VimtexCompile!")
	end,
})
