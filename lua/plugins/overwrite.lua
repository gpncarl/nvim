return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        theme = "auto",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = { hijack_netrw_behavior = "disabled" },
    },
  },
  {
    "stevearc/overseer.nvim",
    optional = true,
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<leader>ow", false },
      { "<leader>oo", false },
      { "<leader>oq", false },
      { "<leader>oi", false },
      { "<leader>ob", false },
      { "<leader>ot", false },
      { "<leader>oc", false },
      { "<leader>Ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>Oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>Oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>Oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
      { "<leader>Ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
      { "<leader>Ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>Oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
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
    "saghen/blink.cmp",
    optional = true,
    opts = {
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = false },
      },
      signature = { enabled = true },
      keymap = {
        preset = "enter",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      preset = "helix",
      spec = {
        { "<leader>o", group = "orgmode" },
        { "<leader>O", group = "overseer" },
      },
    },
  },
  {
    "folke/flash.nvim",
    optional = true,
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
    "neovim/nvim-lspconfig",
    optional = true,
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
    optional = true,
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
    optional = true,
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
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
    },
  },
}
