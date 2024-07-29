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
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<C-_>"] = actions.toggle_preview,
          ["<C-/>"] = actions.toggle_preview,
          ["<C-h>"] = telescope.extensions.hop.hop,
        },
      },
      sorting_strategy = "ascending",
      -- layout_strategy = "horizontal",
      -- layout_config = { prompt_position = "top", preview_width = 0.6, height = 0.5, width = 0.8 },
      layout_config = { prompt_position = "top" },
      -- layout_config = { prompt_position = "top", mirror = true, anchor = "N" },
      border = true,
      preview = { hide_on_startup = true }
    }
  }

  telescope.load_extension("fzf")
  telescope.load_extension("hop")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = (config.finder == "telescope"),
    cmd = "Telescope",
    keys = {
      { "go",         "<cmd>Telescope treesitter buffer=0<cr>",            desc = "fuzzy outline" },
      { "<space>ff",  "<cmd>Telescope find_files<cr>",                     desc = "fuzzy files" },
      { "<space>gf",  "<cmd>Telescope git_files show_untracked=false<cr>", desc = "fuzzy git files" },
      { "<space>b",   "<cmd>Telescope buffers<cr>",                        desc = "fuzzy buffers" },
      { "<leader>gr", "<cmd>Telescope grep_string<cr>",                    desc = "fuzzy string" },
      { "<space>gr",  "<cmd>Telescope live_grep<cr>",                      desc = "live fuzzy string" },
      { "<space>j",   "<cmd>Telescope jumplist<cr>",                       desc = "fuzzy jumplist" },
      { "<space>t",   "<cmd>Telescope tagstack<cr>",                       desc = "fuzzy tagstack" },
      { "<space>q",   "<cmd>Telescope quickfix<cr>",                       desc = "fuzzy quickfix" },
      { "<space>l",   "<cmd>Telescope loclist<cr>",                        desc = "fuzzy loclist" },
      { "<space>re",  "<cmd>Telescope resume<cr>",                         desc = "fuzzy resume" },
      { "<space>ab",  "<cmd>Telescope builtin<cr>",                        desc = "fuzzy all built-in" },
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
    keys = { { "<space>m", "<Cmd>Telescope frecency<CR>", desc = "fuzzy files by frecency" } },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    enabled = (config.finder == "fzf"),
    cmd = "FzfLua",
    keys = {
      { "<space>fo",  "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fuzzy outline" },
      { "<space>ff",  "<cmd>FzfLua files<cr>",                desc = "fuzzy files" },
      { "<space>gf",  "<cmd>FzfLua git_files<cr>",            desc = "fuzzy git files" },
      { "<space>m",   "<cmd>FzfLua oldfiles<cr>",             desc = "fuzzy oldfiles" },
      { "<space>t",   "<cmd>FzfLua tagstack<cr>",             desc = "fuzzy tagstack" },
      { "<space>b",   "<cmd>FzfLua buffers<cr>",              desc = "fuzzy buffers" },
      { "<leader>gr", "<cmd>FzfLua grep<cr>",                 desc = "fuzzy string" },
      { "<space>gr",  "<cmd>FzfLua live_grep<cr>",            desc = "live fuzzy string" },
      { "<space>j",   "<cmd>FzfLua jumps<cr>",                desc = "fuzzy jumplist" },
      { "<space>q",   "<cmd>FzfLua quickfix<cr>",             desc = "fuzzy quickfix" },
      { "<space>l",   "<cmd>FzfLua loclist<cr>",              desc = "fuzzy loclist" },
      { "<space>re",  "<cmd>FzfLua resume<cr>",               desc = "fuzzy resume" },
      { "<space>ab",  "<cmd>FzfLua builtin<cr>",              desc = "fuzzy all built-in" },
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
          ["<C-_>"] = "toggle-preview",
          ["<C-/>"] = "toggle-preview",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "hidden",
      },
    }
  }
}
