return {
  {
    "stevearc/oil.nvim",
    enabled = not (vim.g.user_enable_nvim_dir_plugin and pcall(require, "nvim.dir")),
    cmd = "Oil",
    init = function()
      vim.g.loaded_nvim_dir_plugin = true
      local oil_group = require("utils").augroup("oil_start_directory")
      local load_on_dir = function(path)
        local stats = vim.uv.fs_stat(path)
        if stats and stats.type == "directory" then
          require("oil")
          vim.api.nvim_del_augroup_by_id(oil_group)
        end
      end
      vim.api.nvim_create_autocmd("VimEnter", {
        group = oil_group,
        once = true,
        callback = function()
          load_on_dir(vim.fn.argv(0))
        end,
      })
      vim.api.nvim_create_autocmd("BufNew", {
        group = oil_group,
        callback = function()
          load_on_dir(vim.api.nvim_buf_get_name(0))
        end
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
