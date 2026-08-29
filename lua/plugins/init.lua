return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "wsdjeg/vim-fetch",
    lazy = false,
    config = function()
      MiniMisc.safely("later", function()
        vim.keymap.del({ "n", "x" }, "gF")
      end)
    end
  },
  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    opts = {
      preset = "helix",
      defer = function(ctx)
        return ctx.mode == "v" or ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.add({
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
        { "<leader>a",        group = "ai" },
        { "<leader>b",        group = "buffer" },
        { "<leader>f",        group = "fuzzy" },
        { "<leader>t",        group = "trouble" },
        { "<leader>g",        group = "git" },
        { "<leader>n",        group = "neotree" },
        { "<leader>s",        group = "search" },
        { "<leader><leader>", group = "extra" },
        {
          "<leader><leader>b",
          group = "buffers",
          expand = require("which-key.extras").expand.buf,
        },
        {
          "<leader><leader>w",
          group = "windows",
          function()
            wk.show({ keys = "<c-w>", loop = true })
          end,
        },
        {
          "<leader><leader>z",
          group = "horizontal scroll",
          function()
            wk.show({ keys = "z", loop = true })
          end,
        },
      })
      wk.setup(opts)
    end
  }
}
