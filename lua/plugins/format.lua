return {
    {
        "Wansmer/treesj",
        keys = { "<leader>J" },
        cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require "treesj".setup{
                use_default_keymaps = false,
            }
            vim.keymap.set('n', '<leader>J', require('treesj').toggle)
        end
    }
}
