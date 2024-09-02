local config = require("config")
return {
  {
    "kawre/leetcode.nvim",
    enabled = config.leetcode,
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      cn = { enabled = true },
      injector = {
        ["python3"] = {
          before = true
        },
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
          after = "int main() {}",
        },
        ["java"] = {
          before = "import java.util.*;",
        },
      }
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
