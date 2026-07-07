vim.pack.add({ "https://github.com/goolord/alpha-nvim" })
local function configure()
	local theme = require("alpha.themes.theta")
	local themeconfig = theme.config
	local dashboard = require("alpha.themes.dashboard")

	local header = {
		type = "text",
		val = {
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
		},
		opts = {
			position = "center",
			hl = "Type",
			-- wrap = "overflow";
		},
	}

	local buttons = {
		type = "group",
		val = {
			{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
			{ type = "padding", val = 1 },
			dashboard.button("f", "  Find file", ":lua require('fzf-lua').files() <CR>"),
			dashboard.button("t", "  Find text", " :lua requwre('fzf-lua').live_grep() <CR>"),
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
			dashboard.button("u", "  Update plugins", ":lua vim.pack.update()<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		},
		position = "center",
	}

	themeconfig.layout[2] = header
	themeconfig.layout[6] = buttons

	return themeconfig
end

require("alpha").setup(configure())
