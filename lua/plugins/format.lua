return {
    { "godlygeek/tabular", lazy = true },
    {
        "Wansmer/treesj",
        keys = { "<leader>J" },
        cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = true,
        },
        config = function()
            vim.keymap.set('n', '<leader>J', require('treesj').toggle)
        end
    }
}
