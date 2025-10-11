return {
  {
    "nvim-mini/mini.surround",
    keys = function(_, keys)
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add Surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete Surrounding" },
        { opts.mappings.find,           desc = "Find Right Surrounding" },
        { opts.mappings.find_left,      desc = "Find Left Surrounding" },
        { opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { opts.mappings.replace,        desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = 'l',      -- Suffix to search with "prev" method
        suffix_next = 'n',      -- Suffix to search with "next" method
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
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
        { "gr",               group = "lsp" },
        { "gs",               group = "surround" },
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
  },
}
