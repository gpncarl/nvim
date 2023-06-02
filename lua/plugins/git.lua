return {
    { "tpope/vim-fugitive", event = "CmdlineEnter" },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            trouble = false,
            attach_to_untracked = false
        }
    },
    {
        "sindrets/diffview.nvim",
        event = "CmdlineEnter",
        opts = {}
    },
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        opts = {}
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit"
    }
}
