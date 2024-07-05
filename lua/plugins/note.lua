return {
    {
        "nvim-neorg/neorg",
        ft = { "norg" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            lazy_loading = true,
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.export"] = {},
                ["core.completion"] = { config = { engine = "nvim-cmp" } },
            }
        }
    },
    {
        "nvim-orgmode/orgmode",
        ft = { "org" },
        opts = {},
    },
    {
        "lukas-reineke/headlines.nvim",
        ft = { "norg", "org" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = { fat_headline_lower_string = "▔" },
            org = { fat_headline_lower_string = "▔" },
            norg = { fat_headline_lower_string = "▔" },
        }
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown",
        ft = { "latex" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    {
        "OXY2DEV/markview.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {}
    }
}
