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
      { "go",         "<cmd>Telescope treesitter buffer=0<cr>", desc = "fuzzy outline" },
      { "<leader>fo", "<cmd>Telescope treesitter buffer=0<cr>", desc = "fuzzy outline" },
      { "<leader>fF", "<cmd>Telescope find_files<cr>",          desc = "fuzzy files" },
      {
        "<leader>ff",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            require("telescope.builtin").find_files({ cwd = root })
          else
            require("telescope.builtin").find_files()
          end
        end,
        desc = "fuzzy files(root)"
      },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",   desc = "fuzzy buffers" },
      { "<leader>fG", "<cmd>Telescope live_grep<cr>", desc = "live fuzzy string" },
      {
        "<leader>fg",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            require("telescope.builtin").live_grep({ cwd = root })
          else
            require("telescope.builtin").live_grep()
          end
        end,
        desc = "live fuzzy string(root)"
      },
      { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "fuzzy jumplist" },
      { "<leader>ft", "<cmd>Telescope tagstack<cr>", desc = "fuzzy tagstack" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "fuzzy quickfix" },
      { "<leader>fl", "<cmd>Telescope loclist<cr>",  desc = "fuzzy loclist" },
      { "<leader>fr", "<cmd>Telescope resume<cr>",   desc = "fuzzy resume" },
      { "<leader>fa", "<cmd>Telescope builtin<cr>",  desc = "fuzzy all built-in" },
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
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            require("fzf-lua").files({ cwd = root })
          else
            require("fzf-lua").files()
          end
        end,
        desc = "fuzzy files(root)"
      },
      { "<leader>fF", "<cmd>FzfLua files<cr>",                desc = "fuzzy files(cwd)" },
      { "<leader>fm", "<cmd>FzfLua oldfiles<cr>",             desc = "fuzzy oldfiles" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "fuzzy buffers" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>",             desc = "fuzzy quickfix" },
      { "<leader>fl", "<cmd>FzfLua loclist<cr>",              desc = "fuzzy loclist" },
      { "<leader>fa", "<cmd>FzfLua builtin<cr>",              desc = "fuzzy all built-in" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>",            desc = "live fuzzy string" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fuzzy lsp_document_symbols" },
      { "<leader>sr", "<cmd>FzfLua resume<cr>",               desc = "fuzzy resume" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>",           desc = "fuzzy grep_cword" },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>",           desc = "fuzzy grep_cWORD" },
    },
    opts = {
      winopts = {
        preview = {
          hidden = "hidden",
        }
      },
      keymap = {
        builtin = {
          ["<c-_>"] = "toggle-preview",
          ["<c-/>"] = "toggle-preview",
        },
      },
    }
  },
  {
    "folke/snacks.nvim",
    enabled = (config.finder == "snacks"),
    opts = {
      picker = {}
    },
    keys = {
      { "<leader>fl", function() Snacks.picker.picker_layouts() end,   desc = "" },
      -- Top Pickers & Explorer
      { "<leader><enter>", function() Snacks.picker.smart() end,   desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<leader>/",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            Snacks.picker.grep({ cwd = root })
          else
            Snacks.picker.grep()
          end
        end,
        desc = "Grep"
      },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<leader>ff",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            Snacks.picker.files({ cwd = root })
          else
            Snacks.picker.files()
          end
        end,
        desc = "Find Files(root)"
      },
      { "<leader>fF", function() Snacks.picker.files() end,   desc = "Find Files(cwd)" },
      { "<leader>fr", function() Snacks.picker.recent() end,  desc = "Recent" },
      -- Grep
      {
        "<leader>sg",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            Snacks.picker.grep({ cwd = root })
          else
            Snacks.picker.grep()
          end
        end,
        desc = "Grep"
      },
      { "<leader>sg", function() Snacks.picker.grep() end,                  desc = "Grep" },
      {
        "<leader>sw",
        function()
          local root = vim.fs.root(0, '.git')
          if root ~= nil then
            Snacks.picker.grep_word({ cwd = root })
          else
            Snacks.picker.grep_word()
          end
        end,
        desc = "Visual selection or word()",
        mode = { "n", "x" }
      },
      { "<leader>sW", function() Snacks.picker.grep_word() end,             desc = "Visual selection or word(cwd)", mode = { "n", "x" } },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
      { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
      { "grr",        function() Snacks.picker.lsp_references() end,        nowait = true,                          desc = "References" },
      { "gri",        function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
      { "grt",        function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    },
  }
}
