return {
  {
    "bkad/CamelCaseMotion",
    keys = {
      { "\\w",  "<Plug>CamelCaseMotion_w",  desc = "camel case w" },
      { "\\b",  "<Plug>CamelCaseMotion_b",  desc = "camel case b" },
      { "\\e",  "<Plug>CamelCaseMotion_e",  desc = "camel case e" },
      { "\\ge", "<Plug>CamelCaseMotion_ge", desc = "camel case ge" },
      { "i\\w", "<Plug>CamelCaseMotion_iw", mode = { "x", "o" } },
      { "i\\b", "<Plug>CamelCaseMotion_ib", mode = { "x", "o" } },
      { "i\\e", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "g/",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "gV",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    opts = {
      modes = {
        char = { enabled = false },
      },
    },
  }
}
