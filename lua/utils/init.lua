local M = {}

function M.augroup(name)
  return vim.api.nvim_create_augroup("user_augroup_" .. name, { clear = true })
end

function M.lazywrap(fun)
  return setmetatable({ module = {} }, {
    __index = function(self, method)
      if vim.tbl_isempty(self.module) then
        self.module = fun()
      end
      return self.module[method]
    end
  })
end

function M.bufname_valid(bufname)
  if bufname:match '^/' or bufname:match '^[a-zA-Z]:' or bufname:match '^zipfile://' or bufname:match '^tarfile:' then
    return true
  end
  return false
end

function M.root_dir_wrapper(root_dir, root_markers)
  return function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if not M.bufname_valid(name) then
      return
    end
    if type(root_dir) == "function" then
      root_dir(bufnr, on_dir)
    elseif type(root_dir) == "string" then
      on_dir(root_dir)
    elseif root_markers then
      on_dir(vim.fs.root(bufnr, root_markers))
    end
  end
end

function M.highlight_cursor_line()
  local get_hl = function(ns, opts)
    local hl = vim.api.nvim_get_hl(ns, opts)
    while hl.link ~= nil do
      hl = vim.api.nvim_get_hl(ns, { name = hl.link })
    end
    return hl
  end
  local cl = get_hl(0, { name = "CursorLine" })
  local ln = get_hl(0, { name = "LineNr" })
  local cls = get_hl(0, { name = "CursorLineSign" })
  local clf = get_hl(0, { name = "CursorLineFold" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = ln.fg, bg = cl.bg })
  vim.api.nvim_set_hl(0, "CursorLineSign", { fg = cls.fg, bg = cl.bg })
  vim.api.nvim_set_hl(0, "CursorLineFold", { fg = clf.fg, bg = cl.bg })
end

return M
