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
      "Gwq",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Ghdiffsplit",
    },
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "git blame" },
      { "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "git diff split" }
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "│" },
        -- delete = { text = "" },
        -- topdelete = { text = "" },
        changedelete = { text = "│" },
        untracked = { text = "│" },
      },
      trouble = false,
      attach_to_untracked = false
    }
  },
}
