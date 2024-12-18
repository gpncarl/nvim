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
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewLog",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = { { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" } },
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      default_args = {
        DiffviewOpen = { "-uno" },
        DiffviewFileHistory = {},
      },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open({ cwd = vim.fs.root(0, ".git") })
        end,
        desc = "Open Neogit",
      },
      {
        "<leader>gG",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit (cwd)",
      },
    },
    dependencies = { "sindrets/diffview.nvim" },
    opts = {},
  },
}
