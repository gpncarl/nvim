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
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                    -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                    -- See the section on formatting for more details on how to customize.
                    --- @type NoiceFormat|string
                    format = "lsp_progress",
                    --- @type NoiceFormat|string
                    format_done = "lsp_progress_done",
                    throttle = 1000 / 30, -- frequency to update lsp progress message
                    view = "mini",
                },
            },
            presets = {
                bottom_search = false,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = false, -- long messages will be sent to a split
                inc_rename = true,             -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,         -- add a border to hover docs and signature help
            },
        }
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
}
