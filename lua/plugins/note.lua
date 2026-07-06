return {
  {
    "nvim-orgmode/orgmode",
    dependencies = { "tpope/vim-repeat" },
    cmd = { "Org" },
    ft = { "org" },
    keys = {
      {
        "<leader>oa",
        function()
          require("orgmode").action("agenda.prompt")
        end,
        desc = "org agenda",
      },
      {
        "<leader>oc",
        function()
          require("orgmode").action("capture.prompt")
        end,
        desc = "org capture",
      },
    },
    opts = {
      org_agenda_files = "~/org/*",
      org_default_notes_file = "~/org/notes.org",
      org_startup_indented = true,
      org_startup_folded = "inherit",
    },
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      preview = {
        filetypes = { "markdown", "Avante" },
      }
    }
  }
}
