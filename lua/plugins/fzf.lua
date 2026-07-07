vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

-- Files (project)
vim.keymap.set("n", "<leader>ff", function()
	fzf.files({
		fd_opts = [[--type f --hidden --follow --exclude .git]],
	})
end, { desc = "Find project files" })

-- Files (everything, including ignored)
vim.keymap.set("n", "<leader>fF", function()
	fzf.files({
		fd_opts = [[--type f --hidden --follow --no-ignore --exclude .git]],
	})
end, { desc = "Find all files" })

-- Grep (project)
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep({
		rg_opts = "--column --line-number --no-heading --hidden --smart-case --glob '!.git'",
	})
end, { desc = "Live grep project" })

vim.keymap.set("n", "<leader>fG", function()
	require("fzf-lua").live_grep({
		rg_opts = "--column --line-number --no-heading --hidden --smart-case --no-ignore --glob '!.git'",
	})
end, { desc = "Live grep all files" })

-- Buffers
vim.keymap.set("n", "<leader>fb", fzf.buffers, {
	desc = "Buffers",
})

-- Recent files
vim.keymap.set("n", "<leader>fr", function()
	fzf.oldfiles({
		cwd_only = true,
		include_current_session = true,
	})
end)

vim.keymap.set("n", "<leader>fR", fzf.oldfiles, {
	desc = "Recent files",
})

-- Help tags
vim.keymap.set("n", "<leader>fh", fzf.help_tags, {
	desc = "Help tags",
})

-- LSP
vim.keymap.set("n", "gd", fzf.lsp_definitions, {
	desc = "Goto definition",
})

vim.keymap.set("n", "gr", fzf.lsp_references, {
	desc = "References",
})

vim.keymap.set("n", "gi", fzf.lsp_implementations, {
	desc = "Implementations",
})

vim.keymap.set("n", "gt", fzf.lsp_typedefs, {
	desc = "Type definitions",
})

vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, {
	desc = "Document symbols",
})

vim.keymap.set("n", "<leader>fS", fzf.lsp_workspace_symbols, {
	desc = "Workspace symbols",
})

vim.keymap.set("n", "<leader>fd", fzf.diagnostics_document, {
	desc = "Document diagnostics",
})

vim.keymap.set("n", "<leader>fD", fzf.diagnostics_workspace, {
	desc = "Workspace diagnostics",
})

-- Git
vim.keymap.set("n", "<leader>fc", fzf.git_commits, {
	desc = "Git commits",
})

vim.keymap.set("n", "<leader>fB", fzf.git_branches, {
	desc = "Git branches",
})

vim.keymap.set("n", "<leader>f?", fzf.builtin, {
	desc = "fzf-lua pickers",
})
