local augroup = require("utils").augroup

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    if vim.hl.hl_op then
      vim.hl.hl_op()
    else
      vim.hl.on_yank()
    end
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
