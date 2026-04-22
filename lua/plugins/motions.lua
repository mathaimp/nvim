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
			local get_fg = function(name)
				local hl = vim.api.nvim_get_hl(0, { name = name })
				return hl and hl.fg or "#ffffff"
			end

			return {
				cyclic_navigation = true,
				new_buffer_position = "end",
				num_pages = 2,

				open = {
					by_default = true,
					offset = { x = 0, y = 0 },
					default_position = "top_right",
					ignore_ft = { "gitcommit", "gitrebase" },
				},

				ignore_buff_names = {
					"diffpanel_",
				},

				sort_buffers_by_loaded_status = false,

				theme = {
					unloaded_buffer = get_fg("Comment"),
					shortcut = get_fg("Keyword"),
					active = get_fg("Function"),
					unsaved_indicator = get_fg("Error"),
				},

				leader_key = ";",
				mapping_chars = "qweryuiop",
			}
		end,

		config = function(_, opts)
			local buffon = require("buffon")

			buffon.setup(opts)

			-- core transparency fix (THIS is what you were missing)
			local function transparent()
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
			end

			transparent()

			-- reapply after colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					buffon.setup(opts)
					vim.schedule(transparent)
				end,
			})
		end,
	},
}
