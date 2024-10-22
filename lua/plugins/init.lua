return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("marks").setup({})
      vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr" })
      vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier" })
    end,
  },
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  { "echasnovski/mini.bracketed", keys = { "[", "]" }, opts = {} },
  {
    "bkad/CamelCaseMotion",
    keys = {
      { "\\w", "<Plug>CamelCaseMotion_w", desc = "camel case w" },
      { "\\b", "<Plug>CamelCaseMotion_b", desc = "camel case b" },
      { "\\e", "<Plug>CamelCaseMotion_e", desc = "camel case e" },
      { "\\ge", "<Plug>CamelCaseMotion_ge", desc = "camel case ge" },
      { "i\\w", "<Plug>CamelCaseMotion_iw", mode = { "x", "o" } },
      { "i\\b", "<Plug>CamelCaseMotion_ib", mode = { "x", "o" } },
      { "i\\e", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
    },
  },
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<leader>H", "<cmd>Grapple tag<cr>", desc = "Grapple add tag" },
      { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
}
