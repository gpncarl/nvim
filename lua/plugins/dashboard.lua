return {
  {
    "goolord/alpha-nvim",
    enabled = (vim.g.user_dashboard == "alpha"),
    event = { "VimEnter" },
    cmd = { "Alpha", "AlphaRedraw" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")
      startify.nvim_web_devicons.enabled = true
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        desc = "disable tabline for alpha",
        callback = function()
          vim.opt.showtabline = 0
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaClosed",
        desc = "enable tabline after alpha",
        callback = function()
          vim.opt.showtabline = 2
        end,
      })

      alpha.setup(startify.config)
    end
  },
}
