return {
    {
        "bkad/CamelCaseMotion",
        event = { "ModeChanged *:no", "VeryLazy" },
        init = function()
            vim.g.camelcasemotion_key = "<leader>"
        end
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
