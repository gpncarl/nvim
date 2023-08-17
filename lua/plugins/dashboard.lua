local config = require "config"
return {
    {
        "goolord/alpha-nvim",
        cond = (config.dashboard == "alpha"),
        cmd = { "Alpha", "AlphaRedraw" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            startify.nvim_web_devicons.enabled = true
            return alpha.setup(startify.config)
        end
    },
    {
        "echasnovski/mini.starter",
        cond = (config.dashboard == "mini.starter"),
        lazy = true,
        opts = {
            autoopen = false,
        }
    }
}
