vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
})

-- require("vim._core.ui2").enable({})
require("plugins.theme")
require("plugins.alpha")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			require("plugins.fzf")
			require("plugins.yanky")
			require("plugins.treesitter")
			require("plugins.lang")
			require("plugins.completions")
			vim.cmd.packadd("nvim.undotree")
			vim.keymap.set("n", "<leader>u", "<cmd>Undotree<CR>", {
				desc = "Undo tree",
			})
			require("plugins.misc")
		end)
	end,
})

local oil_setup_done = false
vim.keymap.set("n", "-", function()
	if not oil_setup_done then
		require("oil").setup()
		oil_setup_done = true
	end
	vim.cmd("Oil")
end, { desc = "Open parent directory" })
