return {
    {
        "navarasu/onedark.nvim",
        lazy = true,
        priority = 1000
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        priority = 1000,
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
        lazy = true,
        priority = 1000,
        opts = {},
    }
}
