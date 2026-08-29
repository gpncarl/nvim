local augroup = require("utils").augroup
local group = "MarkSign"

local sign_place = function(mark, bufnr, lnum)
  vim.fn.sign_define(mark, {
    text = mark,
    texthl = "Identifier",
  })
  vim.fn.sign_place(mark:byte(), group, mark, bufnr, { lnum = lnum })
end

local sign_unplace = function(mark, bufnr)
  vim.fn.sign_unplace(group, { buffer = bufnr, id = mark:byte() })
end

vim.api.nvim_create_autocmd("MarkSet", {
  group = augroup("mark_set"),
  pattern = "[a-zA-Z]",
  callback = function(ev)
    local mark = ev.data.name
    local line = ev.data.line
    if line == 0 then
      sign_unplace(mark, ev.buf)
    else
      sign_place(mark, ev.buf, line)
    end
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("buf_enter_set_marks"),
  callback = function(ev)
    local bufnr = ev.buf
    local marks = vim.fn.getmarklist(bufnr)
    vim.list_extend(marks, vim.fn.getmarklist())
    for _, item in ipairs(marks) do
      local mark = item.mark:sub(2)
      if item.pos[1] == bufnr and mark:match("[a-zA-Z]") then
        sign_place(mark, bufnr, item.pos[2])
      end
    end
  end
})

vim.keymap.set("n", "dm", function()
  pcall(vim.cmd, "delmarks " .. string.char(vim.fn.getchar()))
end, { desc = "delete mark"})
