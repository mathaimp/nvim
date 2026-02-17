return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"oskarrrrrrr/symbols.nvim",
		event = "VeryLazy",
		config = function()
			local r = require("symbols.recipes")
			require("symbols").setup(r.DefaultFilters, {
				sidebar = {},
			})
			vim.keymap.set("n", ",s", "<cmd>Symbols<CR>")
			vim.keymap.set("n", ",S", "<cmd>SymbolsClose<CR>")
		end,
	},
	{
		"francescarpi/buffon.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			-- Pull colors from the active theme so Buffon stays theme-agnostic
			local get_fg = function(name)
				local hl = vim.api.nvim_get_hl(0, { name = name })
				return hl and hl.fg or "#ffffff" -- fallback color
			end

			return {
				theme = {
					unloaded_buffer = get_fg("Comment"),
					shortcut = get_fg("Keyword"),
					active = get_fg("Function"),
					unsaved_indicator = get_fg("Error"),
				},
			}
		end,

		-- Optional: reload Buffon colors when you change colorscheme
		config = function(_, opts)
			require("buffon").setup(opts)

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					require("buffon").setup(opts)
				end,
			})
		end,
	},
}
