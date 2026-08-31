local augroup = require("utils").augroup
vim.api.nvim_create_autocmd("BufDelete", {
  group = augroup("nvim_pack_buf_delete"),
  once = true,
  buffer = 0,
  callback = vim.schedule_wrap(function()
    vim.cmd.redrawtabline()
  end)
})
