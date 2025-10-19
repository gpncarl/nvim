local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local ignore_clients = {
        "copilot",
      }
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and not vim.list_contains(ignore_clients, client.name) and client.root_dir then
        vim.b[ev.buf].lsp_root_dir = client.root_dir
      end
    end,
  })
end

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
  return vim.api.nvim_create_augroup("vimaugroup_" .. name, { clear = true })
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

return M
