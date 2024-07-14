local config = require("config")
return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "aklt/plantuml-syntax" },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "folke/which-key.nvim",
        enabled = config.which_key,
        -- keys = { "`", "'", "\"", "<space>", "<leader>" },
        opts = {
            plugins = {
                marks = false,
                registers = false,
                presets = {
                    motions = false,
                    text_objects = false,
                    operators = false
                }
            }
        }
    },
    {
        "tiagovla/scope.nvim",
        enabled = config.scope_buffer,
        opts = {}
    },
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "ZB", function() require("mini.bufremove").delete() end, desc = "Delete Buffer" },
        },
        opts = {}
    },
    {
        "chentoast/marks.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
           require"marks".setup({})
           vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr"})
           vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier"})
        end
    },
}
