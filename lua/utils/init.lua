local M = {}

function M.root(buf)
  local bufnr = buf or vim.api.nvim_get_current_buf()
  local lsp_root_dir = vim.b[bufnr].lsp_root_dir
  if lsp_root_dir then
    return lsp_root_dir
  end
  local marker_root = vim.fs.root(bufnr, { ".git" })
  if marker_root then
    return marker_root
  end
  return vim.uv.cwd()
end

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

return M
