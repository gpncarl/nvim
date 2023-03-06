return {
    {"nvim-lua/popup.nvim", lazy = true },
    {"nvim-tree/nvim-web-devicons", lazy = true },
    {"MunifTanjim/nui.nvim", lazy = true },
    {"rcarriga/nvim-notify", lazy = true, opts = { top_down = false } },
    {
        "folke/noice.nvim",
        lazy = true,
        dependencies = {
            "nvim-notify", "nui.nvim", "nvim-treesitter" },
        config = true
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        dependencies = { "telescope.nvim" }
    },
}
