return {
  {
    "nvim-lualine/lualine.nvim",
    event = "ColorScheme",
    opts = function()
      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          disabled_filetypes = {
            statusline = {
              "alpha",
            },
            winbar = {
              "alpha",
              "qf",
              "toggleterm",
              "snacks_terminal",
              "checkhealth",
              "gitcommit",
              "neo-tree",
              "fugitive",
              "help",
              "git",
              "",
            }
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
          globalstatus = true,
          component_separators = '',
          -- section_separators = { left = '', right = ' ' },
          -- section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "fileformat", "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "%S", "searchcount", "encoding", "filetype" },
          lualine_y = { "lsp_status", "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        extensions = {
          "quickfix",
          "fugitive",
          "lazy",
          "mason",
          "neo-tree",
          "oil",
          "trouble",
          "overseer",
          "toggleterm",
          "man"
        }
      }
    end
  },
  {
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    keys = {
      { "gb", "<cmd>BufferLinePick<cr>", desc = "BufferLine Pick" },
      { "gB", "<cmd>BufferLinePickClose<cr>", desc = "BufferLine Pick Close" },
    },
    opts = {
      options = {
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        mode = "buffers",
        numbers = "buffer_id",
        separator_style = "slant",
        sort_by = "id",
        always_show_bufferline = false,
      }
    }
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")
          if vim.bo[buf].ft == "markdown" then
            return {
              utils.source.fallback({
                sources.treesitter,
                sources.markdown,
                sources.lsp,
              }),
            }
          end
          if vim.bo[buf].buftype == "terminal" then
            return {
              sources.terminal,
            }
          end
          return {
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end
      }
    }
  },
}
