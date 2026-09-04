local augroup = require("utils").augroup

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("git_bufdir"),
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { ".git" })
    if root then
      vim.cmd.bcd(root)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_bufdir"),
  callback = function(ev)
    local ignore_clients = {
      "copilot",
      "copilot_ls",
    }
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not vim.list_contains(ignore_clients, client.name) and client.root_dir then
      vim.cmd.bcd(client.root_dir)
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  group = augroup("lsp_progress"),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local client_name = client.name or "unknown"
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
    if value.kind == "end" and client:supports_method("textDocument/foldingRange") then
      vim.wo.foldexpr = vim.lsp.foldexpr
    end
  end,
})

vim.api.nvim_create_autocmd("TermRequest", {
  group = augroup("terminal_osc7_bufdir"),
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

vim.api.nvim_create_autocmd("ModeChanged", {
  group = augroup("visual_mode_enter"),
  pattern = "[^vV\x16]:[vV\x16]",
  callback = function()
    local cln = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
    local cls = vim.api.nvim_get_hl(0, { name = "CursorLineSign" })
    local clf = vim.api.nvim_get_hl(0, { name = "CursorLineFold" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { link = "LineNr" })
    vim.api.nvim_set_hl(0, "CursorLineSign", { link = "SignColumn" })
    vim.api.nvim_set_hl(0, "CursorLineFold", { link = "FoldColumn" })
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = augroup("visual_mode_leave"),
      once = true,
      pattern = "[vV\x16]:[^vV\x16]",
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", cln)
        vim.api.nvim_set_hl(0, "CursorLineSign", cls)
        vim.api.nvim_set_hl(0, "CursorLineFold", clf)
      end
    })
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("set_cursor_line_hl_on_colorscheme_change"),
  callback = require("utils").highlight_cursor_line
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = augroup("set_cursor_line_hl_on_backgroud_change"),
  pattern = "background",
  callback = require("utils").highlight_cursor_line
})
