return {
    {
        "phaazon/hop.nvim",
        keys = "<leader><leader>",
        config = function()
            local h = require("hop")
            h.setup({ keys = "etovxqpdygfblzhckisuran" })
            return require("hop_keymap")
        end
    },
    {
        "ggandor/leap.nvim",
        lazy = true,
        dependencies = { "vim-repeat", "leap-spooky" },
        config = function()
            local l = require("leap")
            return l.add_default_mappings()
        end
    },
    {
        "ggandor/leap-spooky.nvim",
        lazy = true,
        config = true
    },
    { "ggandor/flit.nvim", lazy = true, config = true },
    {
        "bkad/CamelCaseMotion",
        event = "ModeChanged *:no",
        keys = { "<leader>w", "<leader>b", "<leader>e", "<leader>ge" },
        init = function()
            vim.g.camelcasemotion_key = "<leader>"
            return nil
        end
    },
}
