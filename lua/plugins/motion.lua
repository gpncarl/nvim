return {
  {
    "bkad/CamelCaseMotion",
    keys = {
      { "<leader>w",  "<Plug>CamelCaseMotion_w",  desc = "camel case w" },
      { "<leader>b",  "<Plug>CamelCaseMotion_b",  desc = "camel case b" },
      { "<leader>e",  "<Plug>CamelCaseMotion_e",  desc = "camel case e" },
      { "<leader>ge", "<Plug>CamelCaseMotion_ge", desc = "camel case ge" },
      { "i<leader>w", "<Plug>CamelCaseMotion_iw", mode = { "x", "o" } },
      { "i<leader>b", "<Plug>CamelCaseMotion_ib", mode = { "x", "o" } },
      { "i<leader>e", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
    },
  },
  {
    "folke/flash.nvim",
    event = "CmdlineEnter",
    opts = {
      modes = {
        char = { enabled = false },
      }
    },
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
  }
}
