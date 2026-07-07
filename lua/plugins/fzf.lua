vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf ---@type table|nil lazily set on first use
local function F(method)
	return function(...)
		if not fzf then
			fzf = require("fzf-lua")
		end
		return fzf[method](...)
	end
end

-- Files (project)
vim.keymap.set("n", "<leader>ff", function()
	F("files")({ fd_opts = "--type f --hidden --follow --exclude .git" })
end, { desc = "Find project files" })

-- Files (everything, including ignored)
vim.keymap.set("n", "<leader>fF", function()
	F("files")({ fd_opts = "--type f --hidden --follow --no-ignore --exclude .git" })
end, { desc = "Find all files" })

-- Grep (project)
vim.keymap.set("n", "<leader>fg", function()
	F("live_grep")({
		rg_opts = "--column --line-number --no-heading --hidden --smart-case --glob '!.git'",
	})
end, { desc = "Live grep project" })

vim.keymap.set("n", "<leader>fG", function()
	F("live_grep")({
		rg_opts = "--column --line-number --no-heading --hidden --smart-case --no-ignore --glob '!.git'",
	})
end, { desc = "Live grep all files" })

-- Buffers
vim.keymap.set("n", "<leader>fb", F("buffers"), { desc = "Buffers" })

-- Recent files
vim.keymap.set("n", "<leader>fr", function()
	F("oldfiles")({ cwd_only = true, include_current_session = true })
end)

vim.keymap.set("n", "<leader>fR", F("oldfiles"), { desc = "Recent files" })

-- Help tags
vim.keymap.set("n", "<leader>fh", F("help_tags"), { desc = "Help tags" })

-- LSP
vim.keymap.set("n", "gd", F("lsp_definitions"), { desc = "Goto definition" })
vim.keymap.set("n", "gr", F("lsp_references"), { desc = "References" })
vim.keymap.set("n", "gi", F("lsp_implementations"), { desc = "Implementations" })
vim.keymap.set("n", "gt", F("lsp_typedefs"), { desc = "Type definitions" })
vim.keymap.set("n", "<leader>fs", F("lsp_document_symbols"), { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fS", F("lsp_workspace_symbols"), { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>fd", F("diagnostics_document"), { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>fD", F("diagnostics_workspace"), { desc = "Workspace diagnostics" })

-- Git
vim.keymap.set("n", "<leader>fc", F("git_commits"), { desc = "Git commits" })
vim.keymap.set("n", "<leader>fB", F("git_branches"), { desc = "Git branches" })
vim.keymap.set("n", "<leader>f?", F("builtin"), { desc = "fzf-lua pickers" })
