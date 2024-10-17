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
    keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" } },
    dependencies = { "sindrets/diffview.nvim" },
    opts = {}
  },
  {
    "isakbm/gitgraph.nvim",
    cmd = "GitGraph",
    keys = { { "<leader>gG", "<cmd>GitGraph<cr>", desc = "Open GitGraph" } },
    opts = {
      symbols = {
        -- commit = '○',
        -- commit_end = '○',
        -- merge_commit = '●',
        -- merge_commit_end = '●',
      },
      format = {
        timestamp = "%Y-%m-%d %H:%M:%S",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.cmd("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
      },
    },
    config = function(_, opts)
      require("gitgraph").setup(opts)
      vim.api.nvim_create_user_command("GitGraph", function()
        vim.cmd("tabnew")
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end, {})
    end
  },
}
