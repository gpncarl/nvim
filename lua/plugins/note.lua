return {
    {
        "nvim-neorg/neorg",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { 'org' },
        config = function()
            require('orgmode').setup_ts_grammar()
            require('orgmode').setup {}
        end
    }
}
