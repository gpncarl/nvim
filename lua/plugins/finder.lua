local config = require("config")

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = (config.finder == "telescope"),
    cmd = { "Telescope" },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release --fresh && cmake --build build --config Release"
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          }
        },
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
            },
          },
          mappings = {
            i = {
              ["<c-_>"] = layout.toggle_preview,
              ["<c-/>"] = layout.toggle_preview,
              ["<c-o>"] = actions.move_selection_better + actions.toggle_selection,
            },
            n = {
              ["q"] = require("telescope.actions").close,
              ["<c-o>"] = actions.move_selection_better + actions.toggle_selection,
            },
          },
          path_display = { "filename_first" },
          -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          -- preview = { hide_on_startup = true }
        }
      }

      telescope.load_extension("fzf")
    end
  },
  {
    "ibhagwan/fzf-lua",
    enabled = (config.finder == "fzf_lua"),
    cmd = { "FzfLua" },
    opts = {
      fzf_opts = {
        ["--cycle"] = true
      },
      winopts = {
        preview = {
          -- hidden = "hidden",
        }
      },
      keymap = {
        builtin = {
          ["<c-_>"] = "toggle-preview",
          ["<c-/>"] = "toggle-preview",
        },
      },
    },
  },
  {
    "2KAbhishek/pickme.nvim",
    cmd = { "PickMe" },
    keys = function()
      local pickme = require("pickme")
      return {
        { "<leader>,",  function() pickme.pick("buffers") end,                                        desc = "Buffers" },
        { "<leader>/",  function() pickme.pick("live_grep", { cwd = require("utils").root() }) end,   desc = "Grep(root)" },
        { "<leader>fo", function() pickme.pick("treesitter") end,                                     desc = "Treesitter" },
        { "<leader>fb", function() pickme.pick("buffers") end,                                        desc = "Buffers" },
        { "<leader>ff", function() pickme.pick("files", { cwd = require("utils").root() }) end,       desc = "Find Files(root)" },
        { "<leader>fF", function() pickme.pick("files") end,                                          desc = "Find Files(cwd)" },
        { "<leader>fr", function() pickme.pick("oldfiles") end,                                       desc = "Recent" },
        { "<leader>sg", function() pickme.pick("live_grep", { cwd = require("utils").root() }) end,   desc = "Grep(root)" },
        { "<leader>sG", function() pickme.pick("live_grep") end,                                      desc = "Grep(cwd)" },
        { "<leader>sR", function() pickme.pick("resume") end,                                         desc = "Resume" },
        { "<leader>sw", function() pickme.pick("grep_string", { cwd = require("utils").root() }) end, desc = "Visual selection or word(root)", mode = { "n", "x" } },
        { "<leader>sW", function() pickme.pick("grep_string") end,                                    desc = "Visual selection or word(cwd)",  mode = { "n", "x" } },
        { "gd",         function() pickme.pick("lsp_definitions") end,                                desc = "Goto Definition" },
        { "gD",         function() pickme.pick("lsp_declarations") end,                               desc = "Goto Declaration" },
        { "grr",        function() pickme.pick("lsp_references") end,                                 nowait = true,                           desc = "References" },
        { "gri",        function() pickme.pick("lsp_implementations") end,                            desc = "Goto Implementation" },
        { "grt",        function() pickme.pick("lsp_type_definitions") end,                           desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() pickme.pick("lsp_document_symbols") end,                           desc = "LSP Symbols" },
        { "<leader>sS", function() pickme.pick("lsp_workspace_symbols") end,                          desc = "LSP Workspace Symbols" },
      }
    end,
    opts = {
      picker_provider = config.finder,
      detect_provider = false,
      add_default_keybindings = false,
    }
  }
}
