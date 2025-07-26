-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set
local del = vim.keymap.del

del({"n","x"}, "j")
del({"n","x"}, "k")
del({"n", "o", "x"}, "n")
del({"n", "o", "x"}, "N")
del({"n"}, "<C-H>")
del({"n"}, "<C-J>")
del({"n"}, "<C-K>")
del({"n"}, "<C-L>")

set("t", "<C-W>", "<C-\\><C-N><C-W>")
set("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {
  desc = ":help CTRL-L-default",
})
