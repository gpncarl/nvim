local M = {}

local options = {}
local min_severity = vim.diagnostic.severity.ERROR
local severity_name = {
    [vim.diagnostic.severity.ERROR] = "ERROR",
    [vim.diagnostic.severity.WARN] = "WARN",
    [vim.diagnostic.severity.INFO] = "INFO",
    [vim.diagnostic.severity.HINT] = "HINT",
}
local keys = { "float", "jump", "signs", "underline", "virtual_lines", "virtual_text" }

local function set_diagnostic()
  local opts = vim.deepcopy(options)
  for k, v in pairs(opts) do
    if vim.list_contains(keys, k) then
      local t = type(v)
      if t == "table" then
        opts[k]["severity"] = { min = min_severity }
      elseif t == "function" then
        opts[k] = function(...)
          local opt = v(...)
          opt["severity"] = { min = min_severity }
        end
      end
    end
  end
  vim.diagnostic.config(opts)
end

function M.increase_severity(count)
  count = count or 1
  min_severity = math.max(vim.diagnostic.severity.ERROR, min_severity - count)
  set_diagnostic()
  local msg = "set min diagnostic severity to " .. severity_name[min_severity]
  vim.notify(msg, vim.log.levels.INFO)
end

function M.decrease_severity(count)
  count = count or 1
  min_severity = math.min(vim.diagnostic.severity.HINT, min_severity + count)
  set_diagnostic()
  local msg = min_severity and ("set min diagnostic severity to " .. severity_name[min_severity]) or "disable diagnostic severity"
  vim.notify(msg, vim.log.levels.INFO)
end

function M.setup(opts, severity)
  options = opts
  min_severity = severity
  set_diagnostic()
end

local diagnostic_opts = {
  jump = {},
  underline = {},
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
}
M.setup(diagnostic_opts, vim.diagnostic.severity.ERROR)

local map = vim.keymap.set
map("n", "<leader>]d", function()
  require("utils.diagnostic").increase_severity()
end, { desc = "increase diagnostic min severity" })

map("n", "<leader>[d", function()
  require("utils.diagnostic").decrease_severity()
end, { desc = "decrease diagnostic min severity" })

map("n", "<leader>]D", function()
  require("utils.diagnostic").increase_severity(4)
end, { desc = "increase diagnostic min severity to ERROR" })

map("n", "<leader>[D", function()
  require("utils.diagnostic").decrease_severity(4)
end, { desc = "decrease diagnostic min severity to HINT" })
