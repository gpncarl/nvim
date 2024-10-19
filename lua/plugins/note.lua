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
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      filetypes = { "markdown", "Avante" },
    }
  }
}
