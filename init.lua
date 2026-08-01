vim.g.user_colorscheme = "default"
vim.g.user_dashboard = ""
vim.g.user_picker = "snacks"
vim.g.user_ts_context = false
vim.g.user_popup_cmdline = false
vim.g.user_leetcode = false
vim.g.user_animate = false
vim.g.user_enable_winbar = false
vim.g.user_enable_nvim_dir_plugin = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })
require('zpack').setup()
vim.cmd.colorscheme(vim.g.user_colorscheme)
