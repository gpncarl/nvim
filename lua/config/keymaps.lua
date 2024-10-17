-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")
vim.keymap.del({"n","x"}, "j")
vim.keymap.del({"n","x"}, "k")
vim.keymap.del("n", "<c-h>")
vim.keymap.del("n", "<c-j>")
vim.keymap.del("n", "<c-k>")
vim.keymap.del("n", "<c-l>")
