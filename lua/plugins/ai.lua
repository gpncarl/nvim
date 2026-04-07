return {
  {
    "carlos-algms/agentic.nvim",
    enabled = false,
    opts = {
      provider = "claude-agent-acp",
    },
    keys = {
      {
        "<leader>aa",
        function() require("agentic").toggle() end,
        mode = { "n", "v" },
        desc = "Toggle Agentic Chat"
      },
      {
        "<leader>at",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context"
      },
      {
        "<leader>an",
        function() require("agentic").new_session() end,
        mode = { "n", "v" },
        desc = "New Agentic Session"
      },
      {
        "<leader>ar",
        function()
          require("agentic").restore_session()
        end,
        desc = "Agentic Restore session",
        silent = true,
        mode = { "n", "v" },
      },
    },
  },
  {
    "folke/sidekick.nvim",
    enabled = false,
    cmd = { "Sidekick" },
    keys = {
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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
    opts = {},
  },
}
