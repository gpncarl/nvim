return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = {},
    },
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
}
