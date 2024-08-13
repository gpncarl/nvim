local config = require("config")
return {
  { "nvim-lua/popup.nvim",  lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "OXY2DEV/helpview.nvim",
    ft = { "help" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = {
      extension = {
        h = { glyph = "" },
        hh = { glyph = "" },
        hpp = { glyph = "" },
        c = { glyph = "" },
        cc = { glyph = "" },
        cpp = { glyph = "" },
        cppm = { glyph = "" },
      },
      lsp = {
        tabnine = { glyph = "⌬" },
        copilot = { glyph = "" },
      }
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = config.popup_notify,
    event = "VeryLazy",
    opts = {
      render = "default",
      top_down = false,
    }
  },
  {
    "folke/noice.nvim",
    enabled = config.popup_cmdline,
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        progress = {
          enabled = false,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    }
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {}
  },
  {
    "echasnovski/mini.animate",
    enabled = config.animate,
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },
}
