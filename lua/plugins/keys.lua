return {
  { "tpope/vim-rsi",              event = { "InsertEnter", "CmdlineEnter" } },
  { "echasnovski/mini.bracketed", keys = { "[", "]" },                      opts = {} },
  {
    "echasnovski/mini.surround",
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
        add = "gsa",                    -- Add surrounding in Normal and Visual modes
        delete = "gsd",                 -- Delete surrounding
        find = "gsf",                   -- Find surrounding (to the right)
        find_left = "gsF",              -- Find surrounding (to the left)
        highlight = "gsh",              -- Highlight surrounding
        replace = "gsr",                -- Replace surrounding
        update_n_lines = "gsn",         -- Update `n_lines`
        suffix_last = 'l',              -- Suffix to search with "prev" method
        suffix_next = 'n',              -- Suffix to search with "next" method
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "ModeChanged *:no",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
  },
}
