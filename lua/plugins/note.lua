return {
    {
        "nvim-neorg/neorg",
        dependencies = { "nvim-treesitter" },
        opts = {
            lazy_loading = true,
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.manoeuvre"] = {},
                ["core.journal"] = { config = { workspace = "journal" } },
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
}
