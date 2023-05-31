return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        opts = {
            filetype_exclude = { "help", "terminal", "norg", "alpha" },
            buftype_exclude = { "terminal" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = true
        }
    },
}
