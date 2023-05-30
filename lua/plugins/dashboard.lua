return {
    {
        "goolord/alpha-nvim",
        cond = function()
            return (vim.fn.argc() == 0)
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            startify.nvim_web_devicons.enabled = true
            startify.section.bottom_buttons.val = {}
            return alpha.setup(startify.config)
        end
    },
}
