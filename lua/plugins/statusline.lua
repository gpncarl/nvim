return {
  {
    "nvim-lualine/lualine.nvim",
    event = "ColorScheme",
    opts = function()
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        -- hl_group = "lualine_c_normal",
      })

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
              "gitcommit",
              "neo-tree",
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
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "%S", "searchcount", "encoding", "fileformat", "filetype" },
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
        winbar = {
          lualine_c = {
            { symbols.get, cond = symbols.has, }
          },
        },
        extensions = { "quickfix", "fugitive", "lazy", "mason", "neo-tree", "oil", "trouble" }
      }
    end
  },
  {
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    keys = {
      { "gb", "<cmd>BufferLinePick<cr>", desc = "BufferLine Pick" },
    },
    opts = {
      options = {
        mode = "buffers",
        numbers = "buffer_id",
        separator_style = "slant",
        sort_by = "id",
      }
    }
  },
}
