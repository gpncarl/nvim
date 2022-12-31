local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local hotpot_path = vim.fn.stdpath('data') .. '/lazy/hotpot.nvim'
if not vim.loop.fs_stat(hotpot_path) then
  print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
  vim.fn.system({'git', 'clone',
                 'https://github.com/rktjmp/hotpot.nvim', hotpot_path})
  vim.cmd("helptags " .. hotpot_path .. "/doc")
end
vim.opt.rtp:prepend(hotpot_path)

require "hotpot"
require "setup"
