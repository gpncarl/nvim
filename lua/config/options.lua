-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local g = vim.g
local opt = vim.opt

g.autoformat = false

opt.number = false
opt.relativenumber = true
opt.mouse = "nv"
opt.cursorline = false
opt.matchpairs:append({ "<:>" })
opt.cmdheight = 0
opt.clipboard = ""
opt.splitbelow = false
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.confirm = false
opt.undofile = false
opt.autowrite = true
opt.autowriteall = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
