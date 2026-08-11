return {
  {
    "kawre/leetcode.nvim",
    enabled = vim.g.user_leetcode,
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      { "3rd/image.nvim", opts = {} },
      { "MunifTanjim/nui.nvim", },
      { "nvim-treesitter/nvim-treesitter", },
    },
    opts = {
      cn = { enabled = true },
      image_support = true,
    },
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
}
