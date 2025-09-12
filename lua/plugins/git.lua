return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Git",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Gedit",
      "Gsplit",
      "Gvsplit",
      "Gtabedit",
      "Gpedit",
      "Gdrop",
      "Gread",
      "Gwrite",
      "Gw",
      "Gwq",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Ghdiffsplit",
    },
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "git summary" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "git blame" },
      { "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "git diff split" }
    },
  },
  {
    "nvim-mini/mini.diff",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>go",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = require("utils.icons").git.added,
          change = require("utils.icons").git.modified,
          delete = require("utils.icons").git.removed,
        },
      },
    },
  },
}
