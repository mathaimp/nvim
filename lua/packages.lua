vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
})

-- require("vim._core.ui2").enable({})
require("plugins.theme")
require("plugins.alpha")
require("plugins.fzf")
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			require("plugins.yanky")
			require("plugins.treesitter")
			require("plugins.lang")
			require("plugins.completions")
			vim.cmd.packadd("nvim.undotree")
			vim.keymap.set("n", "<leader>u", "<cmd>Undotree<CR>", {
				desc = "Undo tree",
			})
		end)
	end,
})
