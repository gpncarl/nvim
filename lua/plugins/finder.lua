local config = require("config")
local function telescope_config()
  local telescope = require("telescope")
  local actions = require("telescope.actions.layout")
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
          ["<c-_>"] = actions.toggle_preview,
          ["<c-/>"] = actions.toggle_preview,
          ["<c-h>"] = function(bufnr)
            telescope.extensions.hop._hop(bufnr, {
              callback = function()
                vim.api.nvim_input("<cr>")
              end
            })
          end,
          ["<c-s-h>"] = telescope.extensions.hop.hop,
        },
        n = { ["q"] = require("telescope.actions").close },
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
      { "<leader>fo", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fuzzy outline" },
      { "<leader>ff", "<cmd>FzfLua files<cr>",                desc = "fuzzy files" },
      { "<leader>fm", "<cmd>FzfLua oldfiles<cr>",             desc = "fuzzy oldfiles" },
      { "<leader>ft", "<cmd>FzfLua tagstack<cr>",             desc = "fuzzy tagstack" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "fuzzy buffers" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",            desc = "live fuzzy string" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>",                desc = "fuzzy jumplist" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>",             desc = "fuzzy quickfix" },
      { "<leader>fl", "<cmd>FzfLua loclist<cr>",              desc = "fuzzy loclist" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>",               desc = "fuzzy resume" },
      { "<leader>fa", "<cmd>FzfLua builtin<cr>",              desc = "fuzzy all built-in" },
    },
    opts = {
      "telescope",
      prompt = " ",
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
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "hidden",
      },
    }
  }
}
