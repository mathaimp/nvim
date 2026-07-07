local M = {}

local NONE = "NONE"

local function color(group, attr)
	local hl = vim.api.nvim_get_hl(0, { name = group })

	local value = hl[attr]
	if not value then
		return NONE
	end

	return string.format("#%06x", value)
end

-- Helper to issue highlight commands

local function hi(group, opts)
	local hl = {}
	if opts.guibg and opts.guibg ~= NONE then
		hl.bg = opts.guibg
	end
	if opts.guifg and opts.guifg ~= NONE then
		hl.fg = opts.guifg
	end
	if opts.gui then
		for _, attr in ipairs(vim.split(opts.gui, ",")) do
			hl[attr] = true
		end
	end
	vim.api.nvim_set_hl(0, group, hl)
end

hi("StatusLine", { guibg = NONE, guifg = NONE })
hi("StatusLineNC", { guibg = NONE, guifg = NONE })

hi("StatusMode", {
	guibg = NONE,
	guifg = color("Function", "fg"),
	gui = "bold",
})
hi("StatusModeToNorm", {
	guibg = NONE,
	guifg = color("Function", "fg"),
})

-- Git
hi("StatusGit", {
	guibg = NONE,
	guifg = color("Directory", "fg"),
	gui = "bold",
})
hi("StatusGitToNorm", {
	guibg = NONE,
	guifg = color("Comment", "fg"),
})

hi("StatusDiffAdd", {
	guibg = NONE,
	guifg = color("Added", "fg"),
	gui = "bold",
})
hi("StatusDiffChange", {
	guibg = NONE,
	guifg = color("Changed", "fg"),
	gui = "bold",
})
hi("StatusDiffDelete", {
	guibg = NONE,
	guifg = color("Removed", "fg"),
	gui = "bold",
})

-- File
hi("StatusFile", {
	guibg = NONE,
	guifg = NONE,
	gui = "bold",
})
hi("StatusFileToNorm", {
	guibg = NONE,
	guifg = NONE,
})

-- LSP
hi("StatusLSP", {
	guibg = NONE,
	guifg = NONE,
	gui = "bold",
})
hi("StatusLSPToNorm", {
	guibg = NONE,
	guifg = NONE,
})

-- Diagnostics
hi("StatusErrorIcon", {
	guibg = NONE,
	guifg = color("DiagnosticError", "fg"),
	gui = "bold",
})
hi("StatusWarnIcon", {
	guibg = NONE,
	guifg = color("DiagnosticWarn", "fg"),
	gui = "bold",
})
hi("StatusInfoIcon", {
	guibg = NONE,
	guifg = color("DiagnosticInfo", "fg"),
	gui = "bold",
})
hi("StatusHintIcon", {
	guibg = NONE,
	guifg = color("DiagnosticHint", "fg"),
})

-- Right side
hi("StatusBuffer", {
	guibg = NONE,
	guifg = color("Comment", "fg"),
})

hi("StatusType", {
	guibg = NONE,
	guifg = color("Type", "fg"),
})

hi("StatusTypeToNorm", {
	guibg = NONE,
	guifg = NONE,
})

hi("StatusNorm", {
	guibg = NONE,
	guifg = NONE,
})

hi("StatusLocation", {
	guibg = NONE,
	guifg = color("Comment", "fg"),
})

hi("StatusPercent", {
	guibg = NONE,
	guifg = color("Statement", "fg"),
	gui = "bold",
})

local fn = vim.fn

-- Git repo/branch with caching - uses gitsigns buffer variables for performance

local function get_git_branch()
	local branch = vim.b.gitsigns_head

	if not branch or branch == "" then
		return ""
	end

	-- Get repo name from gitsigns status dict if available

	local gs = vim.b.gitsigns_status_dict

	if gs and gs.root then
		-- Extract repo name from the root path

		local repo_name = vim.fn.fnamemodify(gs.root, ":t")

		return repo_name .. "/" .. branch
	end

	return branch
end

local function build_git_diff()
	local gs = vim.b.gitsigns_status_dict or {}

	local added = gs.added or 0

	local changed = gs.changed or 0

	local removed = gs.removed or 0

	local diff_str = ""

	if added > 0 then
		diff_str = diff_str .. "%#StatusDiffAdd# " .. added .. " "
	end

	if changed > 0 then
		diff_str = diff_str .. "%#StatusDiffChange# " .. changed .. " "
	end

	if removed > 0 then
		diff_str = diff_str .. "%#StatusDiffDelete# " .. removed .. " "
	end

	-- reset to StatusLine for everything that follows

	return diff_str .. "%#StatusLine#"
end

-- Diagnostics symbols

local function get_diagnostics()
	if not vim.diagnostic then
		return ""
	end

	local d = vim.diagnostic.get(0)

	local e, w, i, h = 0, 0, 0, 0

	for _, v in ipairs(d) do
		if v.severity == vim.diagnostic.severity.ERROR then
			e = e + 1
		elseif v.severity == vim.diagnostic.severity.WARN then
			w = w + 1
		elseif v.severity == vim.diagnostic.severity.INFO then
			i = i + 1
		elseif v.severity == vim.diagnostic.severity.HINT then
			h = h + 1
		end
	end

	local s = ""

	if e > 0 then
		s = s .. "%#StatusErrorIcon# " .. e .. " "
	end

	if w > 0 then
		s = s .. "%#StatusWarnIcon# " .. w .. " "
	end

	if i > 0 then
		s = s .. "%#StatusInfoIcon# " .. i .. " "
	end

	if h > 0 then
		s = s .. "%#StatusHintIcon# " .. h .. " "
	end

	-- reset to StatusLine for following text

	return s .. "%#StatusLine#"
end

-- File icon

local function get_file_icon()
	local ok, icons = pcall(require, "nvim-web-devicons")

	if not ok then
		return ""
	end

	local f = fn.expand("%:t")

	local e = fn.expand("%:e")

	local icon = icons.get_icon(f, e, { default = true })

	return icon and icon .. " " or ""
end

-- Word count & reading time

local function word_reading()
	local ft = vim.bo.filetype

	if ft:match("md") or ft:match("markdown") or ft == "text" then
		local w = fn.wordcount().words or 0

		return w .. "w " .. " " .. math.ceil(w / 200) .. "m"
	end

	return ""
end

-- Mode icons

local mode_icons = {

	n = " NORMAL",

	c = " COMMAND",

	t = " TERMINAL",

	i = " INSERT",

	R = " REPLACE",

	V = " V-LINE",

	[" "] = " V-BLOCK", -- Visual Block

	r = " R-PENDING",

	v = " VISUAL",
}

-- 4) Build statusline

function M.build()
	local st = ""

	-- A: mode

	local m = fn.mode()

	st = st .. "%#StatusMode# " .. (mode_icons[m] or m) .. " " .. "%#StatusModeToNorm#"

	-- B: git

	local br = get_git_branch()

	if br ~= "" then
		st = st .. "%#StatusGit# " .. " " .. br .. " " .. "%#StatusGitToNorm#"

		local git_diff = build_git_diff()

		if git_diff ~= "" then
			st = st .. git_diff .. "%#StatusGitToNorm#"
		end
	end

	-- C: filename

	-- local fnm = fn.expand("%:t")

	local fnm = fn.expand("%:.")

	if fnm ~= "" then
		st = st .. "%#StatusFile# " .. fnm .. " " .. (vim.bo.modified and " " or "") .. "%#StatusFileToNorm#"
	end

	local di = get_diagnostics()

	if di ~= "" then
		st = st .. "%#StatusLSP# " .. di .. " " .. "%#StatusLSPToNorm#"
	end

	-- right align

	st = st .. "%="

	-- X: filetype

	local ft = vim.bo.filetype

	if ft ~= "" then
		st = st .. "%#StatusType# " .. get_file_icon() .. ft .. "%#StatusTypeToNorm#"
	end

	-- Y: word/reading

	local wr = word_reading()

	if wr ~= "" then
		st = st .. "%#StatusBuffer# " .. " " .. wr
	end

	-- Z: encoding, format, location, percent

	st = st
		.. "%#StatusBuffer# "
		.. vim.bo.fileencoding
		.. " "
		.. "%#StatusLocation# %l:%c "
		.. "%#StatusPercent# %p%% "

	return st
end

vim.opt.laststatus = 3 -- global statusline

vim.opt.showmode = false -- Dont show mode since we have a statusline

vim.o.statusline = "%!v:lua.require('plugins.status').build()"

return M
