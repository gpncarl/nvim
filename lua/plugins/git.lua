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
        opts = {},
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
}
