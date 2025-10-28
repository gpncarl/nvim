return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    keys = {
      {
        "<leader>a",
        vim.schedule_wrap(function()
          vim.keymap.del({ "n", "v" }, "<leader>a")
          vim.api.nvim_input(vim.keycode("<leader>a"))
        end),
        mode = { "n", "v" }
      },
    },
    build = ":AvanteBuild",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      provider = "cursor-agent",
      acp_providers = {
        ["cursor-agent"] = {
          command = "node",
          args = { vim.fs.abspath("~/cursor-acp/dist/index.js") },
          env = {},
        },
      },
      input = { provider = "snacks" },
      selecter = { provider = "snacks" },
    },
  },
  {
    "folke/sidekick.nvim",
    cmd = { "Sidekick" },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select({ filter = { installed = true } }) end,
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
    opts = {},
  },
}
