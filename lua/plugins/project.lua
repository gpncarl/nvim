return {
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<C-S-H>", "<cmd>Grapple tag<cr>",         desc = "Grapple add tag" },
      { "<C-H>",   "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.sessions",
    event = "SessionLoadPost",
    opts = {}
  }
}
