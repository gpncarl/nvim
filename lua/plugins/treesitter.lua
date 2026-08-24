return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local ensure_installed = { "bash", "lua", "c", "cpp", "python", "vim", "comment", "vimdoc" }
      require('nvim-treesitter').install(ensure_installed)
      vim.api.nvim_create_autocmd("FileType", {
        group = require("utils").augroup("treesitter_enable"),
        desc = "auto enable treesitter",
        callback = function()
          local ok = pcall(function() vim.treesitter.start() end)
          if ok then
            vim.wo.foldexpr = vim.treesitter.foldexpr
            vim.bo.indentexpr = require("nvim-treesitter").indentexpr
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = function()
      local key_spec = {}
      local select = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      }
      for key, query in pairs(select) do
        key_spec[#key_spec + 1] = {
          key,
          function()
            require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
          end,
          mode = { "o", "x" },
          desc = "TS textobject select " .. query,
          silent = true,
        }
      end

      local move = {
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        goto_next = { ["]e"] = "@conditional.outer", },
        goto_previous = { ["[e"] = "@conditional.outer", },
      }

      for method, keymaps in pairs(move) do
        for key, query in pairs(keymaps) do
          key_spec[#key_spec + 1] = {
            key,
            function()
              if vim.wo.diff and key:find("[cC]") then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end,
            mode = { "n", "x", "o" },
            desc = "TS textobject move " .. method .. " " .. query,
            silent = true,
          }
        end
      end

      return key_spec
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup()
      local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = vim.g.user_ts_context,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
