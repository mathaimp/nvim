vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
})

require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.jump").setup()
vim.keymap.set("n", "<leader>E", require("mini.files").open)
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end)

require("noice").setup({
	cmdline = { view = "cmdline" },
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

-- git
vim.keymap.set("n", "]h", require("gitsigns").next_hunk)
vim.keymap.set("n", "[h", require("gitsigns").prev_hunk)

vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk)
vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk)

vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk)

vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end)

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false },
		ghost_text = {
			enabled = true,
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
