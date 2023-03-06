return {
    { "onsails/lspkind-nvim",         lazy = true },
    { "hrsh7th/cmp-path",             lazy = true },
    { "hrsh7th/cmp-buffer",           lazy = true },
    { "hrsh7th/cmp-nvim-lsp",         lazy = true },
    { "rafamadriz/friendly-snippets", lazy = true },
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        lazy = true
    },
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
        dependencies = { "LuaSnip" }
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = { "friendly-snippets" },
        config = function()
            local loader = require("luasnip/loaders/from_vscode")
            local ls = require("luasnip")
            loader.lazy_load()
            return ls.setup({ history = true, delete_check_events = "TextChanged" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = { "lspkind-nvim", "cmp-path", "cmp-buffer",
            "cmp-tabnine", "cmp_luasnip", "cmp-nvim-lsp" },
        config = function()
            require("autocompletion")
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "nvim-cmp" },
        config = function()
            local ap = require("nvim-autopairs")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            ap.setup({ disable_filetype = { "TelescopePrompt", "vim" }, enable_check_bracket_line = false })
            return (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
        end
    },
}
