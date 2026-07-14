vim.pack.add({ {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	version = "main",
} })

require("nvim-treesitter").install({
	"lua",
	"python",
	"regex",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local ok, ts = pcall(require, "nvim-treesitter")
		if not ok then
			return
		end

		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang then
			return
		end

		if vim.tbl_contains(ts.get_available(), lang) and not vim.tbl_contains(ts.get_installed(), lang) then
			ts.install(lang)
		end
	end,
})
