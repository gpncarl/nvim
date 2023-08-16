return {
    { "nvim-lua/plenary.nvim",           lazy = true },
    { "antoinemadec/FixCursorHold.nvim", event = "VeryLazy" },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "folke/which-key.nvim",
        lazy = true,
        -- keys = { "`", "'", "\"", "<space>", "<leader>" },
        opts = {
            plugins = {
                marks = false,
                registers = false,
                presets = {
                    motions = false,
                    text_objects = false,
                    operators = false
                }
            }
        }
    },
    {
        "tiagovla/scope.nvim",
        lazy = true,
        opts = {
            restore_state = false, -- experimental
        }
    }
}
