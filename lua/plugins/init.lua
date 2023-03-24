return {
    { "nvim-lua/plenary.nvim",           lazy = true },
    { "antoinemadec/FixCursorHold.nvim", event = "VeryLazy" },
    {
        "folke/which-key.nvim",
        keys = { "`", "'", "\"", "<space>", "<leader>" },
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
}
