return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Ggrep",
            "Git",
            "Gclog",
            "Gllog",
            "Gcd",
            "Glcd",
            "Gedit",
            "Gsplit",
            "Gvsplit",
            "Gtabedit",
            "Gpedit",
            "Gdrop",
            "Gread",
            "Gwrite",
            "Gwq",
            "Gdiffsplit",
            "Gvdiffsplit",
            "Ghdiffsplit",
        }
    },
    {
        "echasnovski/mini.diff",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<space>go",
                function()
                    require("mini.diff").toggle_overlay(0)
                end,
                desc = "Toggle mini.diff overlay",
            },
        },
        opts = {
            view = {
                style = "sign",
                signs = {
                    add = "▎",
                    change = "▎",
                    delete = "",
                },
            },
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewLog",
            "DiffviewRefresh",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
        },
        opts = {}
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = "sindrets/diffview.nvim",
        opts = {}
    },
    {
        "echasnovski/mini-git",
        cond = false,
        main = "mini.git",
        opts = {},
    }
}
