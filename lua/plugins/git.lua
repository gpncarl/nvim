return {
    { "tpope/vim-fugitive",      event = "CmdlineEnter" },
    { "lewis6991/gitsigns.nvim", event = "VeryLazy",    opts = { trouble = false, attach_to_untracked = false } },
}
