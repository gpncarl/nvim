local config = require("config")
return {
  {
    "hoob3rt/lualine.nvim",
    event = "ColorScheme",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = { statusline = {}, winbar = {} },
        ignore_focus = {},
        always_divide_middle = true,
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        globalstatus = true,
        component_separators = '',
        -- section_separators = { left = '', right = ' ' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "%S", "searchcount", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
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
      extensions = { "quickfix", "fugitive" }
    }
  },
  {
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    enabled = config.bufferline,
    opts = {
      options = {
        mode = "buffers",
        numbers = "buffer_id",
        separator_style = "slant",
        sort_by = "id",
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
