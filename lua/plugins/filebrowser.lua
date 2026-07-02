return {
  {
    "stevearc/oil.nvim",
    enabled = not pcall(require, "nvim.dir"),
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>nt", "<cmd>Neotree toggle<cr>",         desc = "Neotree toggle" },
      { "<leader>nb", "<cmd>Neotree buffers toggle<cr>", desc = "Neotree buffers toggle" }
    },
    opts = {
      buffers = { follow_current_file = { enabled = true }, group_empty_dirs = true, show_unloaded = true },
      filesystem = { hijack_netrw_behavior = "disabled" }
    }
  }
}
