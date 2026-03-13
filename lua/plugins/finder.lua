local config = require("config")
local function telescope_config()
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
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      mappings = {
        i = {
          ["<c-_>"] = layout.toggle_preview,
          ["<c-/>"] = layout.toggle_preview,
          ["<c-o>"] = actions.move_selection_better + actions.toggle_selection,
          ["<c-h>"] = function(bufnr)
            telescope.extensions.hop._hop(bufnr, {
              callback = function()
                vim.api.nvim_input("<cr>")
              end
            })
          end,
          ["<c-s-h>"] = telescope.extensions.hop.hop,
        },
        n = {
          ["q"] = require("telescope.actions").close,
          ["<c-o>"] = actions.move_selection_better + actions.toggle_selection,
        },
      },
      path_display = { "filename_first" },
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      -- preview = { hide_on_startup = true }
    }
  }

  telescope.load_extension("fzf")
  telescope.load_extension("hop")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = (config.finder == "telescope"),
    cmd = { "Telescope" },
    keys = {
      { "<leader>fo", "<cmd>Telescope treesitter buffer=0<cr>", desc = "fuzzy outline" },
      { "<leader>fF", "<cmd>Telescope find_files<cr>",          desc = "fuzzy files" },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ cwd = require("utils").root() })
        end,
        desc = "fuzzy files(root)"
      },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",   desc = "fuzzy buffers" },
      { "<leader>sG", "<cmd>Telescope live_grep<cr>", desc = "live fuzzy string" },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep({ cwd = require("utils").root() })
        end,
        desc = "live fuzzy string(root)"
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep({ cwd = require("utils").root() })
        end,
        desc = "live fuzzy string(root)"
      },
      { "<leader>fr", "<cmd>Telescope resume<cr>",               desc = "fuzzy resume" },
      { "<leader>fa", "<cmd>Telescope builtin<cr>",              desc = "fuzzy all built-in" },
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "Goto Definition" },
      { "gD",         "<cmd>Telescope lsp_definitions<cr>",      desc = "Goto Declaration" },
      { "grr",        "<cmd>Telescope lsp_references<cr>",       nowait = true,                  desc = "References" },
      { "gri",        "<cmd>Telescope lsp_implementations<cr>",  desc = "Goto Implementation" },
      { "grt",        "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto T[y]pe Definition" },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release --fresh && cmake --build build --config Release"
      },
      { "nvim-telescope/telescope-hop.nvim" },
    },
    config = telescope_config
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    enabled = (config.finder == "telescope"),
    cmd = { "Mru" },
    keys = { { "<leader>fm", "<cmd>Mru<cr>", desc = "fuzzy files by frecency" } },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("frecency")
      vim.api.nvim_create_user_command("Mru", function()
        vim.cmd("Telescope frecency")
      end, {})
    end,
  },
  {
    "ibhagwan/fzf-lua",
    enabled = (config.finder == "fzf"),
    cmd = { "FzfLua" },
    keys = {
      { "<leader>fo", "<cmd>FzfLua treesitter<cr>",           desc = "fuzzy treesitter" },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files({ cwd = require("utils").root() })
        end,
        desc = "fuzzy files(root)"
      },
      { "<leader>fF", "<cmd>FzfLua files<cr>",                desc = "fuzzy files(cwd)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",             desc = "fuzzy oldfiles" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "fuzzy buffers" },
      { "<leader>fa", "<cmd>FzfLua builtin<cr>",              desc = "fuzzy all built-in" },
      { "<leader>/",  "<cmd>FzfLua live_grep<cr>",            desc = "live fuzzy string" },
      {
        "<leader>/",
        function()
          require("fzf-lua").live_grep({ cwd = require("utils").root() })
        end,
        desc = "fuzzy files(root)"
      },
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep({ cwd = require("utils").root() })
        end,
        desc = "fuzzy files(root)"
      },
      { "<leader>sG", "<cmd>FzfLua live_grep<cr>",            desc = "live fuzzy string" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fuzzy lsp_document_symbols" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>",               desc = "fuzzy resume" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>",           desc = "fuzzy grep_cword" },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>",           desc = "fuzzy grep_cWORD" },
      { "gd",         "<cmd>FzfLua lsp_definitions<cr>",      desc = "Goto Definition" },
      { "gD",         "<cmd>FzfLua lsp_definitions<cr>",      desc = "Goto Declaration" },
      { "grr",        "<cmd>FzfLua lsp_references<cr>",       nowait = true,                      desc = "References" },
      { "gri",        "<cmd>FzfLua lsp_implementations<cr>",  desc = "Goto Implementation" },
      { "grt",        "<cmd>FzfLua lsp_type_definitions<cr>", desc = "Goto T[y]pe Definition" },
    },
    init = function()
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
