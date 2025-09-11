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

local function closed(line)
  return vim.fn.foldclosed(line) >= 0
end

local function opened(line)
  return tostring(vim.treesitter.foldexpr(line)):sub(1, 1) == ">"
end

function M.clickfold()
  local mousepos = vim.fn.getmousepos()
  vim.api.nvim_set_current_win(mousepos.winid)
  vim.api.nvim_win_set_cursor(0, { mousepos.line, 0 })
  if closed(mousepos.line) then
    vim.fn.execute("norm! zo")
  elseif opened(mousepos.line) then
    vim.fn.execute("norm! zc")
  end
end

function M.statuscolumn()
  local hl = ""
  local text = vim.opt.fillchars:get().foldsep or ""
  if vim.v.virtnum ~= 0 then
  elseif closed(vim.v.lnum) then
    text = vim.opt.fillchars:get().foldclose or ""
    hl = "Folded"
  elseif opened(vim.v.lnum) then
    text = vim.opt.fillchars:get().foldopen or ""
    if vim.v.relnum == 0 then
      hl = "CursorLineNr"
    end
  end
  return "%s%=%l %@v:lua.require'utils'.clickfold@%#" .. hl .. "#" .. text .. " %*%T"
end

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()

  -- don't use treesitter folds for non-file buffers
  if vim.bo[buf].buftype ~= "" then
    return "0"
  end

  -- as long as we don't have a filetype, don't bother
  -- checking if treesitter is available (it won't)
  if vim.bo[buf].filetype == "" then
    return "0"
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
