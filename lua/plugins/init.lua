return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("Oil_start_directory", { clear = true }),
        desc = "Start Oil with directory",
        once = true,
        callback = function()
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then
            require("oil")
          end
        end,
      })
    end,
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    opts = {},
  },
  { "typicode/bg.nvim" },
  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("marks").setup({})
      vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr" })
      vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier" })
    end,
  },
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  {
    "bkad/CamelCaseMotion",
    keys = function()
      vim.g.camelcasemotion_key = "\\"
      local key_spec = {}
      for _, key in ipairs({ "w", "b", "e", "ge" }) do
        key_spec[#key_spec + 1] = {
          vim.g.camelcasemotion_key .. key,
          mode = { "n", "v", "o" },
          desc = "camel case " .. key
        }
        key_spec[#key_spec + 1] = {
          "i" .. vim.g.camelcasemotion_key .. key,
          mode = { "v", "o" }
        }
      end
      return key_spec
    end
  },
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<leader>H", "<cmd>Grapple tag<cr>", desc = "Grapple add tag" },
      { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
}
