return {
  {
    "nvim-neorg/neorg",
    opts = {
      lazy_loading = true,
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.export"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
      }
    }
  },
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    keys = {
      {
        "<leader>Oa",
        function()
          require("orgmode").action("agenda.prompt")
        end,
        desc = "org agenda",
      },
      {
        "<leader>Oc",
        function()
          require("orgmode").action("capture.prompt")
        end,
        desc = "org capture",
      },
    },
    opts = {
      mappings = { prefix = "<leader>O" },
      org_agenda_files = "~/org/*",
      org_default_notes_file = "~/org/notes.org",
      org_startup_indented = true,
      org_startup_folded = "inherit",
    },
  },
}
