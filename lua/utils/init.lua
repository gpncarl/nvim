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

function M.get_hl(ns, opts)
  local hl = vim.api.nvim_get_hl(ns, opts)
  while hl.link ~= nil do
    hl = vim.api.nvim_get_hl(ns, { name = hl.link })
  end
  return hl
end

return M
