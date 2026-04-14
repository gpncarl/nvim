return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "vim-scripts/a.vim",
    cmd = { "A", "AS", "AV", "AT", "AN", "IH", "IHS", "IHV", "IHT", "IHN" },
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
