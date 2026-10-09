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
}
