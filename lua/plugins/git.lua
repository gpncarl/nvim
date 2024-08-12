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
    }
  },
  {
    "echasnovski/mini.diff",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<space>go",
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
    }
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {}
  },
  {
    "isakbm/gitgraph.nvim",
    cmd = "GitGraph",
    opts = {
      symbols = {
        -- commit = '○',
        -- commit_end = '○',
        -- merge_commit = '●',
        -- merge_commit_end = '●',
      },
      format = {
        timestamp = '%Y-%m-%d %H:%M:%S',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
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
