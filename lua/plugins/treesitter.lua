return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            return require("treesitter")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "ModeChanged *:no",
        keys = { "[", "]" },
        dependencies = { "nvim-treesitter" }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        dependencies = { "nvim-treesitter" }
    },
}
