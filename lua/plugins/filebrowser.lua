return {
    {
        "stevearc/oil.nvim",
        config = function()
            local oil = require("oil")
            oil.setup {}
            return vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<space>ft", "<cmd>Neotree toggle<cr>",         mode = "n", desc = "Neotree toggle" },
            { "<space>fb", "<cmd>Neotree buffers toggle<cr>", mode = "n", desc = "Neotree buffers toggle" } },
        opts = {
            buffers = { follow_current_file = true, group_empty_dirs = true, show_unloaded = true },
            filesystem = { hijack_netrw_behavior = "disabled" }
        }
    }
}
