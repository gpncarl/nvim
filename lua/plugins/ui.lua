local config = require "config"
return {
    { "nvim-lua/popup.nvim",         lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim",        lazy = true },
    {
        "rcarriga/nvim-notify",
        cond = config.popup_notify,
        opts = { top_down = false }
    },
    {
        "folke/noice.nvim",
        cond = config.popup_cmdline,
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
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,        -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                lsp_doc_border = true,         -- add a border to hover docs and signature help
            },
        }
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        cmd = { "ZenMode" },
        opts = {}
    },
    {
        "echasnovski/mini.animate",
        cond = config.animate,
        event = "VeryLazy",
        opts = {}
    },
}
