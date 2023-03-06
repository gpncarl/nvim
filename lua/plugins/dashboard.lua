return {
    {
        "goolord/alpha-nvim",
        cond = function()
            return (vim.fn.argc() == 0)
        end,
        dependencies = { "nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            startify.nvim_web_devicons.enabled = true
            return alpha.setup(startify.config)
        end
    },
}
