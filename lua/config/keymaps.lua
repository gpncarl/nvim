-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({"n","x"}, "j")
vim.keymap.del({"n","x"}, "k")
vim.keymap.del("n", "<C-H>")
vim.keymap.del("n", "<C-J>")
vim.keymap.del("n", "<C-K>")
vim.keymap.del("n", "<C-L>")

vim.keymap.set("t", "<C-W>", "<C-\\><C-N><C-W>")
vim.keymap.set("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {
  desc = ":help CTRL-L-default",
})
