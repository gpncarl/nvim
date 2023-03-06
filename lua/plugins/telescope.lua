return {
    { "nvim-telescope/telescope-fzf-native.nvim", lazy = true, build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim",  lazy = true },
    {
        "nvim-telescope/telescope.nvim",
        keys = "<space>",
        dependencies = {
            "telescope-fzf-native.nvim",
            "telescope-ui-select.nvim",
            "harpoon"
        },
        config = function()
            return require("telescope-config")
        end
    }
}
