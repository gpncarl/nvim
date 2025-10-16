return {
  {
    "nvim-lualine/lualine.nvim",
    event = "ColorScheme",
    opts = function()
      local symbols = setmetatable({ cache = {} }, {
        __index = function(self, method)
          if vim.tbl_isempty(self.cache) then
            local trouble = require("trouble")
            local config = {
              mode = "lsp_document_symbols",
              groups = {},
              title = false,
              filter = { range = true },
              format = " {kind_icon}{symbol.name:WinBar}",
              hl_group = "WinBar",
            }
            self.cache = trouble.statusline(config)
          end
          return self.cache[method]
        end
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
              "fugitive",
              "help",
              "git",
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
            {
              function()
                return "Symbols" .. symbols.get()
              end,
              cond = function()
                return vim.lsp.buf_is_attached(0) and symbols.has()
              end,
              color = "WinBar",
            }
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
}
