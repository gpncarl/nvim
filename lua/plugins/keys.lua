return {
    { "tpope/vim-rsi",        event = { "InsertEnter", "CmdlineEnter" } },
    { "echasnovski/mini.bracketed", keys = { "[", "]" }, opts = {} },
    { "tpope/vim-repeat",     keys = "." },
    {
        "kylechui/nvim-surround",
        keys = {
            { "ds",     mode = "n" },
            { "ys",     mode = "n" },
            { "cs",     mode = "n" },
            { "S",      mode = "v" },
            { "<C-g>s", mode = "i" },
            { "<C-g>S", mode = "i" }
        },
        opts = {}
    },
    {
        "echasnovski/mini.ai",
        -- keys = {
        --   { "a", mode = { "x", "o" } },
        --   { "i", mode = { "x", "o" } },
        -- },
        event = "ModeChanged *:no",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
    },
}
