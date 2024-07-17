local config = require("config")
return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "aklt/plantuml-syntax" },
  {
    "folke/which-key.nvim",
    enabled = config.which_key,
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.add({
        {
          "<space>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
        {
          "gb",
          group = "buffers",
          expand = require("which-key.extras").expand.buf,
        },
      })
      wk.setup(opts)
    end
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "ZB", function() require("mini.bufremove").delete() end, desc = "Delete Buffer" },
    },
    opts = {}
  },
  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "marks".setup({})
      vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr" })
      vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier" })
    end
  },
}
