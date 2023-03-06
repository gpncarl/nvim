return {
    { "navarasu/onedark.nvim", lazy = true, priority = 1000 },
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
            italic = false,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false
        }
    },
}
