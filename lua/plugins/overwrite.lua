return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = { hijack_netrw_behavior = "disabled" },
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
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
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
      { "<leader>fo", "<cmd>Telescope treesitter buffer=0<cr>", desc = "fuzzy outline" },
    },
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end,
  }
}
