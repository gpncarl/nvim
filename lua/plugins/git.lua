return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Ge",
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
      "GDelete",
      "GRemove",
      "GUnlink",
      "GMove",
      "GBrowse",
    },
    dependencies = { "barrettruth/diffs.nvim" }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = require("utils.icons").git.added },
        change = { text = require("utils.icons").git.modified },
        delete = { text = require("utils.icons").git.removed },
        topdelete = { text = require("utils.icons").git.removed },
        changedelete = { text = require("utils.icons").git.removed },
        untracked = { text = "" },
      },
      signs_staged = {
        add = { text = require("utils.icons").git.added },
        change = { text = require("utils.icons").git.modified },
        delete = { text = require("utils.icons").git.removed },
        topdelete = { text = require("utils.icons").git.removed },
        changedelete = { text = require("utils.icons").git.removed },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, silent = true })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]C", function() gitsigns.nav_hunk("last") end, "Last Hunk")
        map("n", "[C", function() gitsigns.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", gitsigns.stage_hunk, "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", gitsigns.reset_hunk, "Reset Hunk")
        map("n", "<leader>ghS", gitsigns.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghR", gitsigns.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gitsigns.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gitsigns.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gitsigns.diffthis("~") end, "Diff This ~")
        map('n', '<leader>ghQ', function() gitsigns.setqflist('all') end, "GitSigns Set QFList (All)")
        map('n', '<leader>ghq', gitsigns.setqflist, "GitSigns Set QFList")
        map('n', '<leader>ghtb', gitsigns.toggle_current_line_blame, "GitSigns Toggle Current Line Blame")
        map('n', '<leader>ghtw', gitsigns.toggle_word_diff, "GitSigns Toggle Word Diff")
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "GitSigns Select Hunk")
      end,
    }
  },
  {
    "barrettruth/diffs.nvim",
    lazy = true,
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
          gitsigns = false,
        },
        conflict = {
          keymaps = {
            ours = "<leader>co",
            theirs = "<leader>ct",
            both = "<leader>cb",
            none = "<leader>c0",
            next = "]x",
            prev = "[x",
          },
        },
      }
    end
  }
}
