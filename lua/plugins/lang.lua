vim.pack.add({ "https://github.com/neovim/nvim-lspconfig", "https://github.com/stevearc/conform.nvim" })

-- LSP
local group = vim.api.nvim_create_augroup("lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,

	callback = function(ev)
		local client_id = ev.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)

		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client_id, ev.buf, {})
		end

		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	end,
})

vim.lsp.enable({
	"lua_ls",
	"ty",
	"rust_analyzer",
	"nixd",
})

--conform
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		lua = { "stylua" },
		nix = { "nixfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({
		async = true,
		lsp_format = "fallback",
	})
end, { desc = "Format buffer" })
