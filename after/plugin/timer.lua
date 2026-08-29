local M = {}

local notify_progress = function(msg, status, percent)
  local opts = {
    id = "0",
    kind = "progress",
    percent = percent,
    source = "utils.timer",
    status = status,
    title = "Timer",
  }
  local history = percent == 0 or status ~= "running"
  vim.api.nvim_echo({{msg}}, history, opts)
end

function M.start(self, du)
  self:stop()
  self.timer = vim.uv.new_timer()
  self.duration = loadstring("return " .. du)()
  notify_progress(string.format("start for %ds", self.duration), "running", 0)
  local tick = 0
  self.timer:start(1000, 1000, vim.schedule_wrap(function()
    tick = tick + 1
    if tick >= self.duration then
      self.timer:close()
      self.timer = nil
      notify_progress("complete", "success", 100)
      return
    end
    notify_progress(string.format("remaining %ds...", self.duration - tick), "running",
      math.floor(100 * tick / self.duration))
  end))
end

function M.stop(self)
  if self.timer ~= nil then
    self.timer:close()
    self.timer = nil
    notify_progress("canceled", "cancel")
  end
end

vim.api.nvim_create_user_command("Timer", vim.schedule_wrap(function(data)
  if data.bang then
    M:stop()
    return
  end
  M:start(data.fargs[1])
end), { nargs = "?", bang = true })
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = require("utils").augroup("close_timer"),
  callback = function()
    M:stop()
  end
})
