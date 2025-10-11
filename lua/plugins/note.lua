return {
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    opts = {},
  },
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      filetypes = { "markdown", "Avante" },
    }
  }
}
