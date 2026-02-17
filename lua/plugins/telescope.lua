return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					hidden = true,
					file_ignore_patterns = { ".git/" },
				})
			end, {})
			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({
					additional_args = function()
						return {
							"--hidden", -- Search hidden files
							"--no-ignore", -- Include .gitignored files
							"--glob",
							"!.git/*", -- Exclude .git directory
						}
					end,
				})
			end, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
