local lspconfig = require("lspconfig")
local nmap
local function _1_(...)
  return vim.keymap.set("n", ...)
end
nmap = _1_
local function on_attach(client, bufnr)
  nmap("gd", vim.lsp.buf.definition, {buffer = bufnr, desc = "goto define"})
  local function _2_(_241)
    return vim.lsp.buf.references(_241, nil)
  end
  nmap("gr", _2_, {buffer = bufnr, desc = "goto ref"})
  nmap("<space>a", vim.lsp.buf.code_action, {buffer = bufnr, desc = "code action"})
  vim.keymap.set({"n", "v"}, "<space>fm", vim.lsp.buf.format, {buffer = bufnr, desc = "format"})
  if (client.name == "clangd") then
    return nmap("<space>sh", "<cmd>ClangdSwitchSourceHeader<cr>", {buffer = bufnr, desc = "switch header"})
  else
    return nil
  end
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {snippetSupport = true, preselectSupport = true, insertReplaceSupport = true, labelDetailsSupport = true, deprecatedSupport = true, commitCharactersSupport = true, tagSupport = {valueSet = {1}}, resolveSupport = {properties = {"documentation", "detail", "additionalTextEdits"}}}
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {underline = true, virtual_text = true, signs = true, update_in_insert = false})
lspconfig.hls.setup({autostart = true, on_attach = on_attach})
lspconfig.pylsp.setup({autostart = true, on_attach = on_attach, capabilities = capabilities})
lspconfig.clangd.setup({autostart = true, filetypes = {"c", "cpp"}, on_attach = on_attach, capabilities = capabilities})
lspconfig.rust_analyzer.setup({autostart = true, on_attach = on_attach, capabilities = capabilities})
lspconfig.gopls.setup({autostart = true, on_attach = on_attach, capabilities = capabilities})
lspconfig.lua_ls.setup({autostart = true, on_attach = on_attach, capabilities = capabilities})
return lspconfig.neocmake.setup({autostart = true, on_attach = on_attach, capabilities = capabilities})