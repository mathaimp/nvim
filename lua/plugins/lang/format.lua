return {
	"zapling/mason-conform.nvim",
	dependencies = { "mason.nvim", "stevearc/conform.nvim" },
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "black" },
				nix = { "nixpkgs-fmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},

			require("mason-conform").setup({}),
		})
	end,
}
