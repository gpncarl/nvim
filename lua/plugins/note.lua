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
    config = function(_, opts)
      require("orgmode").setup(opts)
      vim.schedule(function()
        vim.lsp.enable("org")
      end)
    end
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    opts = {
      preview = {
        enable = false,
      }
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    cmd = { "Obsidian" },
    opts = {
      legacy_commands = false,
      picker = {
        name = "snacks.picker",
      },
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
  },
}
