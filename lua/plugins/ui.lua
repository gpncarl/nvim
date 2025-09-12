local config = require("config")
return {
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "nvim-mini/mini.icons",
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
        supermaven = { glyph = "" },
      }
    },
  },
  {
    "folke/noice.nvim",
    enabled = config.popup_cmdline,
    event = "UIEnter",
    dependencies = {
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
    "folke/twilight.nvim",
    cmd = {
      "Twilight",
      "TwilightEnable",
      "TwilightDisable",
    },
    opts = {}
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    dependencies = { "folke/twilight.nvim" },
    opts = {}
  },
}
