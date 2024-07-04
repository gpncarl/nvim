local config = require("config")
return {
    {
        "goolord/alpha-nvim",
        enabled = (config.dashboard == "alpha"),
        cmd = { "Alpha", "AlphaRedraw" },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            startify.nvim_web_devicons.enabled = true
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                desc = "disable tabline for alpha",
                callback = function()
                    vim.opt.showtabline = 0
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaClosed",
                desc = "enable tabline after alpha",
                callback = function()
                    vim.opt.showtabline = 2
                end,
            })

            alpha.setup(startify.config)
        end
    },
    {
        "nvimdev/dashboard-nvim",
        enabled = (config.dashboard == "dashboard"),
        cmd = "Dashboard",
        opts = {
            theme = "hyper",
            shortcut_type = "number",
            shuffle_letter = false,
            config = {
                week_header = { enable = true, },
                shortcut = {
                    { action = "ene | startinsert", desc = " New File", icon = " ", key = "i" },
                    { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "L" },
                    { action = "Mason", desc = " Mason", icon = " ", key = "m" },
                    { action = "Leet", desc = " Leetcode", icon = " ", key = "l" },
                    { action = function() require("mini.sessions").select() end, desc = " Restore Session", icon = " ", key = "s" },
                    { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
                },
            }
        },
    }
}
