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
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  {
    "bkad/CamelCaseMotion",
    keys = {
      { "\\w", "<Plug>CamelCaseMotion_w", desc = "camel case w" },
      { "\\b", "<Plug>CamelCaseMotion_b", desc = "camel case b" },
      { "\\e", "<Plug>CamelCaseMotion_e", desc = "camel case e" },
      { "\\ge", "<Plug>CamelCaseMotion_ge", desc = "camel case ge" },
      { "i\\w", "<Plug>CamelCaseMotion_iw", mode = { "x", "o" } },
      { "i\\b", "<Plug>CamelCaseMotion_ib", mode = { "x", "o" } },
      { "i\\e", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
    },
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
