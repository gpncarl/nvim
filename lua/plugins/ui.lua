return {
    { "nvim-lua/popup.nvim",         lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim",        lazy = true },
    { "rcarriga/nvim-notify",        lazy = true, opts = { top_down = false } },
    {
        "folke/noice.nvim",
        -- lazy = true,
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        opts = {}
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
}
