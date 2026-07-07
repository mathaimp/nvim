-- Leader
vim.g.mapleader = " "

-- Basic editing
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.cmdheight = 0
vim.opt.wrap = false
-- vim.opt.updatetime = 50
vim.opt.fillchars = {
	eob = " ",
}
vim.opt.completeopt = "popup"

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

-- UI
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.completeopt:append("popup")

-- Window splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
if vim.env.SSH_CONNECTION then
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
else
	vim.opt.clipboard = "unnamedplus"
end

-- Diagnostics
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.diagnostic.config({
				underline = true,
				virtual_text = true,
				severity_sort = true,
				update_in_insert = false,

				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = "󰌵 ",
						[vim.diagnostic.severity.HINT] = " ",
					},
				},
			})
		end)
	end,
})
