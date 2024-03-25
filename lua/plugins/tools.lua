return {
    {
        "luckasRanarison/nvim-devdocs",
        cmd = {
            "DevdocsFetch",
            "DevdocsInstall",
            "DevdocsUninstall",
            "DevdocsOpen",
            "DevdocsOpenFloat",
            "DevdocsOpenCurrent",
            "DevdocsOpenCurrentFloat",
            "DevdocsUpdate",
            "DevdocsUpdateAll"
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- previewer_cmd = "glow",
            -- cmd_args = { "-s", "dark", "-w", "80" },
        },
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "vhyrro/luarocks.nvim" },
        config = function()
            require("rest-nvim").setup()
        end,
    }
}
