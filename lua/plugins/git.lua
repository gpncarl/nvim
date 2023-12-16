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
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "│" },
                topdelete = { text = "│" },
                -- delete = { text = "" },
                -- topdelete = { text = "" },
                changedelete = { text = "│" },
                untracked = { text = "│" },
            },
            trouble = false,
            attach_to_untracked = false
        }
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
        opts = {}
    },
}
