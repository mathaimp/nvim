return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "echasnovski/mini.ai", version = "*" },
    build = ":TSUpdate",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local config = require("nvim-treesitter.config")
        config.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "regex", "query", "markdown", "markdown_inline" },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "csv" },
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
        local spec_treesitter = require("mini.ai").gen_spec.treesitter
        require("mini.ai").setup({
            custom_textobjects = {
                F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                o = spec_treesitter({
                    a = { "@conditional.outer", "@loop.outer" },
                    i = { "@conditional.inner", "@loop.inner" },
                }),
            },
        })
    end,
}
