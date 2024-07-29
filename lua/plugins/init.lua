return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "pteroctopus/faster.nvim",
    opts = {}
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "ZB", function() require("mini.bufremove").delete() end, desc = "Delete Buffer" },
    },
    opts = {}
  },
  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "marks".setup({})
      vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr" })
      vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier" })
    end
  },
}
