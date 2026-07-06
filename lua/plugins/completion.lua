return {
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    version = "1.*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "fang2hou/blink-copilot" },
    },
    opts_extend = { "sources.default" },
    opts = {
      keymap = { preset = "enter" },
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
