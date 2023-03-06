return {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        dependencies = { "nvim-treesitter", "nvim-cmp" },
        opts = {
            load = {
                    ["core.defaults"] = {},
                    ["core.norg.concealer"] = {},
                    ["core.norg.manoeuvre"] = {},
                    ["core.norg.journal"] = { config = { workspace = "journal" } },
                    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                    ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            my_workspace = "~/shared/neorg",
                            journal = "~/shared/journal"
                        }
                    } }
            }
        }
    },
}
