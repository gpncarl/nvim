local config = require "config"
local function setup()
    local lualine = require("lualine")
    return lualine.setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { statusline = {}, winbar = {} },
            ignore_focus = {},
            always_divide_middle = true,
            refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
            globalstatus = true
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename", { "navic", color_correction = nil, navic_opts = nil } },
            lualine_x = { "searchcount", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        extensions = { "quickfix", "fugitive" }
    })
end

return {
    {
        "hoob3rt/lualine.nvim",
        event = "VeryLazy",
        config = setup
    },
    {
        "akinsho/bufferline.nvim",
        cond = config.bufferline,
        opts = {}
    },
    {
        "Bekaboo/dropbar.nvim",
        cond = config.dropbar,
        opts = {}
    },
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = {
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = ' ',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' '
            }
        }
    }
}
