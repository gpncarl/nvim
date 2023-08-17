return {
    {
        "bkad/CamelCaseMotion",
        keys = {
            { "<leader>w",  "<Plug>CamelCaseMotion_w",  desc = "camel case w" },
            { "<leader>b",  "<Plug>CamelCaseMotion_b",  desc = "camel case b" },
            { "<leader>e",  "<Plug>CamelCaseMotion_e",  desc = "camel case e" },
            { "<leader>ge", "<Plug>CamelCaseMotion_ge", desc = "camel case ge" },
            { "i<leader>w", "<Plug>CamelCaseMotion_iw", mode = { "x", "o" } },
            { "i<leader>b", "<Plug>CamelCaseMotion_ib", mode = { "x", "o" } },
            { "i<leader>e", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
        },
    },
    {
        "folke/flash.nvim",
        event = "CmdlineEnter",
        opts = {
            label = {
                uppercase = false,
                after = { 0, 3 },
            },
            modes = {
                char = { enabled = false },
            }
        },
        keys = {
            {
                "<leader>s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "<leader>S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "<leader>r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
        },
    }
}
