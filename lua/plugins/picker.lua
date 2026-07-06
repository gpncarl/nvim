return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = (vim.g.user_picker == "telescope"),
    cmd = { "Telescope" },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release --fresh && cmake --build build --config Release"
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    init = function()
      require("utils.picker").register("telescope", {
        resolve = function(name) return require("telescope.builtin")[name] end,
        overrides = {
          files            = "find_files",
          lsp_declarations = function() vim.lsp.buf.declaration() end,
        },
      })
      vim.ui.select = function(...)
        require("telescope").load_extension("ui-select")
        return vim.ui.select(...)
      end
    end,
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
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
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
      telescope.load_extension("ui-select")
    end
  },
  {
    "ibhagwan/fzf-lua",
    enabled = (vim.g.user_picker == "fzf_lua"),
    cmd = { "FzfLua" },
    init = function()
      require("utils.picker").register("fzf_lua", {
        resolve = function(name) return require("fzf-lua")[name] end,
        overrides = {
          grep_string          = "grep_cword",
          lsp_type_definitions = "lsp_typedefs",
        },
      })
      vim.ui.select = function(...)
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end,
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
}
