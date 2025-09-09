return {
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<leader>H", "<cmd>Grapple tag<cr>",         desc = "Grapple add tag" },
      { "<leader>h",   "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
  {
    "nvim-mini/mini.sessions",
    event = "SessionLoadPost",
    opts = {}
  }
}
