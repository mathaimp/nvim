return {
	"rose-pine/neovim",
	lazy = false,
	name = "rose-pine",
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			extend_background_behind_borders = true,

			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
		})
		vim.cmd.colorscheme("rose-pine-main")
	end,
}
