local function config()
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
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
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
    { "SmiteshP/nvim-gps", lazy = true, opts = {} },
    {
        "hoob3rt/lualine.nvim",
        event = "BufEnter",
        config = config
    },
    {
        "akinsho/bufferline.nvim",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
    {
        "Bekaboo/dropbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    }
}
