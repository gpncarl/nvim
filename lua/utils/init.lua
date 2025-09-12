local M = { cached_lsp_root = {} }

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local bufnr = ev.buf
      local root_dir = client.root_dir
      if client and root_dir then
        M.cached_lsp_root[bufnr] = root_dir
      end
    end,
  })
end

function M.root(buf)
  local bufnr = buf or vim.api.nvim_get_current_buf()
  local lsp_root = M.cached_lsp_root[bufnr]
  if lsp_root then
    return lsp_root
  end
  local marker_root = vim.fs.root(bufnr, { ".git" })
  if marker_root then
    return marker_root
  end
  return vim.uv.cwd()
end

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo[buf].buftype ~= "" then
    return "0"
  end

  local ignore_filetypes = { "", "snacks_picker_preview" }
  for _, ft in ipairs(ignore_filetypes) do
    if vim.bo[buf].filetype == ft then
      return "0"
    end
  end

  local ok = pcall(vim.treesitter.get_parser, buf)

  if ok then
    return vim.treesitter.foldexpr()
  end

  return "0"
end

function M.augroup(name)
  return vim.api.nvim_create_augroup("vimaugroup_" .. name, { clear = true })
end

return M
