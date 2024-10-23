return {
  {
    "nvim-neorg/neorg",
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
}
