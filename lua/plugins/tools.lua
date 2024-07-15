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
  }
}
