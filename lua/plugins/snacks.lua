return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>z",       function() Snacks.zen() end,                                               desc = "Toggle Zen Mode" },
      { "<leader>Z",       function() Snacks.zen.zoom() end,                                          desc = "Toggle Zoom" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                         desc = "Delete Buffer" },
      { "<c-\\><c-\\>",    function() Snacks.terminal.toggle() end,                                   desc = "Terminal",                       mode = { "n", "t" } },
      { "<c-n>",           function() Snacks.words.jump(1, true) end,                                 desc = "Words next" },
      { "<c-p>",           function() Snacks.words.jump(-1, true) end,                                desc = "Words previous" },
    },
    opts = {
      animate = {
        enabled = vim.g.user_animate
      },
      bigfile = {},
      image = {},
      scope = {},
      indent = {
        chunk = {
          enabled = false,
        }
      },
      input = {},
      picker = {
        enabled = (vim.g.user_picker == "snacks"),
        win = {
          input = {
            keys = {
              ["<c-_>"] = { "toggle_preview", mode = { "i", "n" } },
              ["<c-/>"] = { "toggle_preview", mode = { "i", "n" } },
            }
          }
        }
      },
      quickfile = {},
      statuscolumn = {
        left = { "mark", "sign", "git" },
        right = { "fold" },
        folds = {
          open = true,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      },
      words = {},
      terminal = {
        win = {
          keys = {
            term_normal = false,
            q = false,
          },
        },
      },
      zen = {},
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
      vim.api.nvim_create_user_command("LazyGit", function() Snacks.lazygit() end, {})
    end,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "default",
        callback = function()
          vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { link = "CursorLine" })
        end,
      })
      require("utils.picker").register("snacks", {
        resolve = function(name) return require("snacks").picker[name] end,
        overrides = {
          oldfiles             = "recent",
          live_grep            = "grep",
          grep_string          = "grep_word",
          lsp_document_symbols = "lsp_symbols",
        },
      })
    end
  }
}
