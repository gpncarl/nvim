vim.g.user_colorscheme = "default"
vim.g.user_dashboard = ""
vim.g.user_finder = "snacks"
vim.g.user_popup_cmdline = false
vim.g.user_leetcode = false
vim.g.user_animate = false
vim.g.user_enable_nvim_dir_plugin = false

require("options")
require("autocmd").setup()
require("misc").setup()
require("utils").setup()

local colorscheme = vim.g.user_colorscheme
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  dev = {
    path = "~/nvim-plugins",
    patterns = {},
    fallback = true,
  },
  install = { colorscheme = { colorscheme } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

})
vim.cmd.colorscheme(colorscheme)
