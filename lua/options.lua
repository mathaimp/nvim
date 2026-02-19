vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true })

vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_exec2(
	[[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END
  ]],
	{}
)

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent update")
		end
	end,
})

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showmode = false
vim.opt.inccommand = "split"
vim.opt.scrolloff = 5

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.clipboard = "unnamedplus"
if
	vim.fn.executable("wl-copy") == 0
	and vim.fn.executable("xclip") == 0
	and vim.fn.executable("xsel") == 0
	and vim.fn.executable("pbcopy") == 0
	and vim.fn.executable("win32yank.exe") == 0
	and vim.fn.executable("clip.exe") == 0
then
	vim.g.clipboard = "osc52"
end

vim.diagnostic.config({
	underline = true,
	update_in_insert = true,
	virtual_text = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = "󰌵",
		},
	},
	document_highlight = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>li", ":Telescope ros2 interfaces<CR>", { desc = "[ROS 2]: List interfaces" })
vim.keymap.set("n", "<leader>ln", ":Telescope ros2 nodes<CR>", { desc = "[ROS 2]: List nodes" })
vim.keymap.set("n", "<leader>la", ":Telescope ros2 actions<CR>", { desc = "[ROS 2]: List actions" })
vim.keymap.set("n", "<leader>lt", ":Telescope ros2 topics_echo<CR>", { desc = "[ROS 2]: List topics" })
vim.keymap.set("n", "<leader>ls", ":Telescope ros2 services<CR>", { desc = "[ROS 2]: List services" })

-- ROS 1

-- Topics list & info
vim.keymap.set("n", "<leader>rtl", function()
	require("ros-nvim.telescope.pickers").topic_picker()
end, { desc = "ROS: List Topics" })

-- Nodes list & info
vim.keymap.set("n", "<leader>rnl", function()
	require("ros-nvim.telescope.pickers").node_picker()
end, { desc = "ROS: List Nodes" })

-- Services list & info
vim.keymap.set("n", "<leader>rsl", function()
	require("ros-nvim.telescope.pickers").service_picker()
end, { desc = "ROS: List Services" })

-- Service definitions list & info
vim.keymap.set("n", "<leader>rds", function()
	require("ros-nvim.telescope.pickers").srv_picker()
end, { desc = "ROS: List SRV Definitions" })

-- Message definitions list & info
vim.keymap.set("n", "<leader>rdm", function()
	require("ros-nvim.telescope.pickers").msg_picker()
end, { desc = "ROS: List MSG Definitions" })

-- Params list & values
vim.keymap.set("n", "<leader>rpl", function()
	require("ros-nvim.telescope.pickers").param_picker()
end, { desc = "ROS: List Parameters" })

-- For Learning
-- vim.keymap.set("", "<up>", "<nop>", { noremap = true })
-- vim.keymap.set("", "<down>", "<nop>", { noremap = true })
-- vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
-- vim.keymap.set("i", "<down>", "<nop>", { noremap = true })

vim.opt.mouse = ""
