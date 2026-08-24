local augroup = require("utils").augroup

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_root_dir"),
  callback = function(ev)
    local ignore_clients = {
      "copilot",
      "copilot_ls",
    }
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and not vim.list_contains(ignore_clients, client.name) and client.root_dir then
      vim.b[ev.buf].lsp_root_dir = client.root_dir
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  group = augroup("lsp_progress"),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or "unknown"
    local value = ev.data.params.value
    local msg = (value.message or "done") .. string.format("(%s)", client_name)
    vim.api.nvim_echo({ { msg } }, value.kind == "end", {
      id = "lsp." .. ev.data.params.token,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end,
})

vim.api.nvim_create_autocmd("TermRequest", {
  group = augroup("terminal_osc7"),
  desc = "Handles OSC 7 dir change requests",
  callback = function(ev)
    local val, n = string.gsub(ev.data.sequence, "\027]7;file://[^/]*", "")
    if n > 0 then
      local dir = val
      if vim.fn.isdirectory(dir) == 0 then
        vim.notify("invalid dir: " .. dir)
        return
      end
      vim.cmd.bcd(dir)
    end
  end
})
