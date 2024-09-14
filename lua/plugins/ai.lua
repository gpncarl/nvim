return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "yetone/avante.nvim",
    keys = {
      { "<leader>aa", "<Plug>(AvanteAsk)",     mode = { "n", "v" }, desc = "avante ask" },
      { "<leader>ae", "<Plug>(AvanteEdit)",    mode = { "v" },      desc = "avante edit" },
      { "<leader>ar", "<Plug>(AvanteRefresh)", mode = { "n" },      desc = "avante refresh" },
    },
    build = ":AvanteBuild",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      provider = "copilot",
      hints = { enabled = false },
      behavior = { auto_set_keymaps = false },
    },
  }
}
