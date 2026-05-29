local config = require("config")
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>fl",      function() Snacks.picker.picker_layouts() end,                             desc = "Layout" },
      { "<leader>fo",      function() Snacks.picker.treesitter() end,                                 desc = "Treesitter" },
      { "<leader><enter>", function() Snacks.picker.smart() end,                                      desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                    desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep({ cwd = require("utils").root() }) end,      desc = "Grep(root)" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                    desc = "Buffers" },
      { "<leader>ff",      function() Snacks.picker.files({ cwd = require("utils").root() }) end,     desc = "Find Files(root)" },
      { "<leader>fF",      function() Snacks.picker.files() end,                                      desc = "Find Files(cwd)" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                     desc = "Recent" },
      { "<leader>fR",      function() Snacks.picker.recent({ filter = { cwd = true } }) end,          desc = "Recent (cwd)" },
      { "<leader>sg",      function() Snacks.picker.grep({ cwd = require("utils").root() }) end,      desc = "Grep(root)" },
      { "<leader>sG",      function() Snacks.picker.grep() end,                                       desc = "Grep(cwd)" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                     desc = "Resume" },
      { "<leader>sw",      function() Snacks.picker.grep_word({ cwd = require("utils").root() }) end, desc = "Visual selection or word(root)", mode = { "n", "x" } },
      { "<leader>sW",      function() Snacks.picker.grep_word() end,                                  desc = "Visual selection or word(cwd)",  mode = { "n", "x" } },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                      desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                               desc = "Grep Open Buffers" },
      { "gd",              function() Snacks.picker.lsp_definitions() end,                            desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                           desc = "Goto Declaration" },
      { "grr",             function() Snacks.picker.lsp_references() end,                             nowait = true,                           desc = "References" },
      { "gri",             function() Snacks.picker.lsp_implementations() end,                        desc = "Goto Implementation" },
      { "grt",             function() Snacks.picker.lsp_type_definitions() end,                       desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                      desc = "LSP Workspace Symbols" },
      { "<leader>z",       function() Snacks.zen() end,                                               desc = "Toggle Zen Mode" },
      { "<leader>Z",       function() Snacks.zen.zoom() end,                                          desc = "Toggle Zoom" },


      { "<leader>bd",      function() Snacks.bufdelete() end,                                         desc = "Delete Buffer" },
      { "<c-\\><c-\\>",    function() Snacks.terminal.toggle() end,                                   desc = "Terminal",                       mode = { "n", "t" } },
      { "<c-n>",           function() Snacks.words.jump(1, true) end,                                 desc = "Words next" },
      { "<c-p>",           function() Snacks.words.jump(-1, true) end,                                desc = "Words previous" },
    },
    opts = {
      animate = {
        enabled = config.animate
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
        enabled = (config.finder == "snacks"),
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
    end
  }
}
