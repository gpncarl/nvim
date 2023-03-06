return {
    { "SmiteshP/nvim-gps", lazy = true, opts = {} },
    {
        "hoob3rt/lualine.nvim",
        config = function()
            return require("statusline")
        end
    },
}
