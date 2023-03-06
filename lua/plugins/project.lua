return {
    {
        "ThePrimeagen/harpoon",
        keys = "<space>",
        dependencies = { "plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<space>ha",
                function() require("harpoon.mark").add_file() end,
                { desc = "harpoon add file" })
            vim.keymap.set("n", "<space>hl",
                function() require("harpoon.ui").toggle_quick_menu() end,
                { desc = "harpoon marks" })
            vim.keymap.set("n", "<space>hn",
                function() require("harpoon.ui").nav_next() end,
                { desc = "harpoon next file" })
            vim.keymap.set("n", "<space>hp",
                function() require("harpoon.ui").nav_prev() end,
                { desc = "harpoon prev file" })
        end
    }
}
