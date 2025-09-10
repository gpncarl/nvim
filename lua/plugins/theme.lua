return {
  { "typicode/bg.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    event = "UIEnter",
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
    event = "UIEnter",
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "UIEnter",
    opts = {},
  },
}
