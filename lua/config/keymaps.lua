-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set
local del = vim.keymap.del
local keymaps = {}
local replace = function(mode, lhs, rhs)
  if keymaps[mode] == nil then
    keymaps[mode] = vim.api.nvim_get_keymap(mode)
  end
  for _, keymap in ipairs(keymaps[mode]) do
    if keymap.lhs == lhs then
      set(mode, rhs, keymap.rhs or keymap.callback, {
        noremap = keymap.noremap,
        silent = keymap.silent,
        desc = keymap.desc,
        nowait = keymap.nowait,
      })
      del(mode, lhs)
      return
    end
  end
end

del({"n","x"}, "j")
del({"n","x"}, "k")
del({"n", "t"}, "<C-H>")
del({"n", "t"}, "<C-J>")
del({"n", "t"}, "<C-K>")
del({"n", "t"}, "<C-L>")

set("t", "<C-W>", "<C-\\><C-N><C-W>")
set("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {
  desc = ":help CTRL-L-default",
})

replace("n", "<C-/>", "<C-\\><C-\\>")
replace("t", "<C-/>", "<C-\\><C-\\>")
replace("n", "<C-_>", "<C-\\><C-\\>")
replace("t", "<C-_>", "<C-\\><C-\\>")
