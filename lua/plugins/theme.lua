return {
  {
    "local/termbg",
    enabled = false,
    priority = 1000,
    lazy = false,
    dev = true,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      strikethrough = true,
      inverse = true,
      contrast = "",
      overrides = {},
      italic = {
        strings = false,
        comments = true,
        folds = true,
        operations = false,
      },
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {},
  },
}
