return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "wsdjeg/vim-fetch",
    lazy = false,
    config = function()
      MiniMisc.safely("later", function()
        vim.keymap.del({"n", "x"}, "gF")
      end)
    end
  },
}
