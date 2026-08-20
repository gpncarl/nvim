vim.api.nvim_create_autocmd("BufDelete", {
  once = true,
  buffer = 0,
  callback = vim.schedule_wrap(function()
    vim.cmd.redrawtabline()
  end)
})
