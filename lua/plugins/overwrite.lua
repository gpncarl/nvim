return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          keys = {
            nav_h = false,
            nav_j = false,
            nav_k = false,
            nav_l = false,
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        completeopt = "menuone,noinsert,noselect",
      },
      experimental = {
        ghost_text = false,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>O", group = "orgmode" },
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
      {
        "g/",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "gV",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    opts = {
      modes = {
        char = { enabled = false },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fo",
        "<cmd>Telescope treesitter buffer=0<cr>",
        desc = "Symbols (treesitter)",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          severity = {
            vim.diagnostic.severity.ERROR,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = false,
          node_incremental = "<Tab>",
          scope_incremental = false,
          node_decremental = "<S-Tab>",
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "header" },
          { section = "startup", padding = 1 },
          { title = "MRU ", file = vim.fn.fnamemodify(".", ":~") },
          { section = "recent_files", cwd = true, limit = 8, padding = 1 },
          { title = "MRU" },
          { section = "recent_files", limit = 8, padding = 1 },
          { title = "Sessions" },
          { section = "projects", padding = 1 },
          { section = "keys" },
        },
      },
    },
  },
}
