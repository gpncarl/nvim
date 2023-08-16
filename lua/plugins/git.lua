return {
    { "tpope/vim-fugitive", event = "CmdlineEnter" },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
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
        "NeogitOrg/neogit",
        cmd = "Neogit",
        opts = {}
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit"
    }
}
