local M = {}

M.sources = {
  "buffers", "files", "oldfiles", "live_grep", "grep_string",
  "treesitter", "resume",
  "lsp_definitions", "lsp_declarations", "lsp_references",
  "lsp_implementations", "lsp_type_definitions",
  "lsp_document_symbols", "lsp_workspace_symbols",
}

local adapters = {}

function M.register(name, spec)
  adapters[name] = spec
end

function M.pick(source, opts)
  if not vim.tbl_contains(M.sources, source) then
    vim.notify(("picker: source '%s' is not supported"):format(tostring(source)), vim.log.levels.WARN)
    return
  end

  opts = opts or {}
  local provider = vim.g.user_picker
  local spec = adapters[provider]
  if not spec then
    vim.notify(("picker: provider '%s' is not registered"):format(tostring(provider)), vim.log.levels.WARN)
    return
  end
  local target = (spec.overrides or {})[source] or source
  if type(target) == "function" then
    return target(opts)
  end
  local fn = spec.resolve(target)
  if type(fn) ~= "function" then
    vim.notify(("picker: provider '%s' does not support '%s'"):format(provider, source), vim.log.levels.WARN)
    return
  end
  return fn(opts)
end

return M
