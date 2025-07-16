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
      keymaps = {
        view = {
          { "n", "<leader>gv", "<cmd>w<cr><cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "<leader>gv", "<cmd>w<cr><cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      default_args = {
        DiffviewOpen = { "-uno" },
        DiffviewFileHistory = {},
      },
      hooks = {
        view_opened = vim.schedule_wrap(function()
          require("diffview.actions").toggle_files()
        end),
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      commit_editor = {
        spell_check = false,
      },
    },
  },
}
