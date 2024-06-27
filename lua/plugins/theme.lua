return {
    {
        "navarasu/onedark.nvim",
        event = "VeryLazy",
    },
    {
        "rebelot/kanagawa.nvim",
        event = "VeryLazy",
    },
    {
        "ellisonleao/gruvbox.nvim",
        event = "VeryLazy",
        opts = {
            undercurl = true,
            underline = true,
            bold = true,
            strikethrough = true,
            inverse = true,
            contrast = "",
            overrides = {},
            italic = {
                strings = false,
                comments = true,
                folds = true,
                operations = false,
            },
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false
        }
    },
    {
        "folke/tokyonight.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        event = "VeryLazy",
        opts = {},
    }
}
