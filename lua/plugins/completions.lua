vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.jump").setup()

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
