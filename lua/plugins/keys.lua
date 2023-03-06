return {
    { "tpope/vim-rsi",        event = { "InsertEnter", "CmdlineEnter" } },
    { "tpope/vim-unimpaired", keys = { "[", "]" } },
    { "tpope/vim-repeat",     keys = "." },
    { "wellle/targets.vim",   event = "ModeChanged *:no" },
    {
        "kylechui/nvim-surround",
        keys = {
            { "ds",     mode = "n" },
            { "ys",     mode = "n" },
            { "cs",     mode = "n" },
            { "S",      mode = "v" },
            { "<C-g>s", mode = "i" },
            { "<C-g>S", mode = "i" }
        },
        config = true
    },
}
