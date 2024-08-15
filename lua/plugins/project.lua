return {
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<c-s-h>", "<cmd>Grapple tag<cr>",         desc = "Grapple add tag" },
      { "<c-h>",   "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.sessions",
    event = "SessionLoadPost",
    opts = {}
  }
}
