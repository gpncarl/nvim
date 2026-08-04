return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    sem_version = "1.*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "fang2hou/blink-copilot" },
    },
    opts = {
      keymap = { preset = "none" },
      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          }
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      cmdline = { enabled = false },
    },
  },
}
