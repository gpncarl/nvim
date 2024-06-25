return {
    {
        "stevearc/oil.nvim",
        keys = {
            {
                "-",
                function()
                    require("oil").open()
                end,
                desc = "Open parent directory"
            },
        },
        event = "User OpenDirectory",
        opts = {}
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<space>ft", "<cmd>Neotree toggle<cr>",         desc = "Neotree toggle" },
            { "<space>fb", "<cmd>Neotree buffers toggle<cr>", desc = "Neotree buffers toggle" } },
        opts = {
            buffers = { follow_current_file = true, group_empty_dirs = true, show_unloaded = true },
            filesystem = { hijack_netrw_behavior = "disabled" }
        }
    }
}
