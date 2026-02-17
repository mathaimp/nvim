return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		lazy = true,
		event = "VimEnter",
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			require("mason").setup({})
			require("mason-lspconfig").setup({
				automatic_installation = true,
				handlers = {
					default_setup,
				},
				ensure_installed = {
					"lua_ls",
					"jsonls",
					"pyright",
					"rust_analyzer",
				},
			})
		end,
	},
}
