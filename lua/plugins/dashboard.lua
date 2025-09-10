return {
  {
    "goolord/alpha-nvim",
    event = { "VimEnter" },
    cmd = { "Alpha", "AlphaRedraw" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")
      startify.nvim_web_devicons.enabled = true
      alpha.setup(startify.config)
    end
  },
}
