return {
    {
        "nvim-neorg/neorg",
        ft = { "norg" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "vhyrro/luarocks.nvim",
        },
        opts = {
            lazy_loading = true,
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.manoeuvre"] = {},
                ["core.journal"] = { config = { workspace = "journal" } },
                ["core.export"] = {},
                ["core.completion"] = { config = { engine = "nvim-cmp" } },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            my_workspace = "~/shared/neorg",
                            journal = "~/shared/journal"
                        }
                    }
                }
            }
        }
    },
    {
        "nvim-orgmode/orgmode",
        ft = { "org" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require('orgmode').setup_ts_grammar()
            require('orgmode').setup {}
        end
    },
    {
        "lukas-reineke/headlines.nvim",
        ft = { "norg", "org", "markdown" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = { fat_headline_lower_string = "▔" },
            org = { fat_headline_lower_string = "▔" },
            norg = { fat_headline_lower_string = "▔" },
        }
    },
}
