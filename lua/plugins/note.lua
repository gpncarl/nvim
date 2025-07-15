return {
  {
    "nvim-neorg/neorg",
    event = "BufReadPre *.norg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.export"] = {},
      },
    },
  },
  {
    "nvim-orgmode/orgmode",
    dependencies = { "tpope/vim-repeat" },
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
}
