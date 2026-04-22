return {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000, -- load before other plugins
	config = function()
		-- optional overrides before setting colorscheme
		vim.g.nord_contrast = true
		vim.g.nord_borders = true
		vim.g.nord_disable_background = true
		vim.g.nord_cursorline_transparent = true
		vim.g.nord_italic = true
		vim.g.nord_bold = true
		vim.g.nord_uniform_diff_background = true

		require("nord").set()
	end,
	-- "rose-pine/neovim",
	-- lazy = false,
	-- name = "rose-pine",
	-- priority = 1000,
	-- config = function()
	-- 	require("rose-pine").setup({
	-- 		extend_background_behind_borders = true,
	--
	-- 		styles = {
	-- 			bold = true,
	-- 			italic = true,
	-- 			transparency = true,
	-- 		},
	-- 	})
	-- 	vim.cmd.colorscheme("rose-pine-main")
	-- end,
}
