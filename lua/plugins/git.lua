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
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
        opts = {}
    }
}
