vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
    severity = {
      vim.diagnostic.severity.ERROR,
    }
  }
})

require("vim._core.ui2").enable({
  enable = false,
  msg = {
    targets = "msg",
  }
})

local map = vim.keymap.set

map("t", "<c-w>", "<c-\\><c-n><c-w>")
map("t", "<esc><esc>", "<c-\\><c-n>")

map("n", "<leader>ch", function()
  if vim.o.autowrite then
    vim.cmd.update()
  end
  local ok = pcall(vim.cmd.LspClangdSwitchSourceHeader) or pcall(vim.cmd.A)
  if not ok then
    vim.notify("Failed to switch source/header", vim.log.levels.ERROR)
  end
end, { desc = "Switch source/header" })

local pick = require("utils.picker").pick
local root = function() return require("utils").root() end

map("n", "<leader>,", function() pick("buffers") end, { desc = "Buffers" })
map("n", "<leader>/", function() pick("live_grep", { cwd = root() }) end, { desc = "Grep(root)" })
map("n", "<leader>fo", function() pick("treesitter") end, { desc = "Treesitter" })
map("n", "<leader>fb", function() pick("buffers") end, { desc = "Buffers" })
map("n", "<leader>ff", function() pick("files", { cwd = root() }) end, { desc = "Find Files(root)" })
map("n", "<leader>fF", function() pick("files") end, { desc = "Find Files(cwd)" })
map("n", "<leader>fr", function() pick("oldfiles") end, { desc = "Recent" })
map("n", "<leader>sg", function() pick("live_grep", { cwd = root() }) end, { desc = "Grep(root)" })
map("n", "<leader>sG", function() pick("live_grep") end, { desc = "Grep(cwd)" })
map("n", "<leader>sR", function() pick("resume") end, { desc = "Resume" })
map({ "n", "x" }, "<leader>sw", function() pick("grep_string", { cwd = root() }) end,
  { desc = "Selection or word(root)" })
map({ "n", "x" }, "<leader>sW", function() pick("grep_string") end, { desc = "Selection or word(cwd)" })

local smap = Snacks.keymap.set
smap("n", "gd", function() pick("lsp_definitions") end, {
  lsp = { method = "textDocument/definition" },
  desc = "Goto Definition"
})
smap("n", "gD", function() pick("lsp_declarations") end, {
  lsp = { method = "textDocument/declaration" },
  desc = "Goto Declaration"
})
smap("n", "grr", function() pick("lsp_references") end, {
  lsp = { method = "textDocument/references" },
  desc = "Goto References",
  nowait = true
})
smap("n", "gri", function() pick("lsp_implementations") end, {
  lsp = { method = "textDocument/implementation" },
  desc = "Goto Implementation"
})
smap("n", "grt", function() pick("lsp_type_definitions") end, {
  lsp = { method = "textDocument/typeDefinition" },
  desc = "Goto Type Definition"
})
smap("n", "<leader>ss", function() pick("lsp_document_symbols") end, {
  lsp = { method = "textDocument/documentSymbol" },
  desc = "LSP Symbols"
})
smap("n", "<leader>sS", function() pick("lsp_workspace_symbols") end, {
  lsp = { method = "workspace/symbol" },
  desc = "LSP Workspace Symbols"
})

local label_last_search = function()
  require("utils.jump").count_label()
end

local label_search = function()
  vim.api.nvim_feedkeys(vim.keycode("<cr>"), "n", false)
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype == "/" or cmdtype == "?" then
    local forward = (cmdtype == "/")
    vim.schedule(function()
      require("utils.jump").count_label(forward)
    end)
  end
end

map({ "n", "x" }, "<s-cr>", label_last_search, { desc = "label last search" })
map({ "n", "x" }, "<c-j>", label_last_search, { desc = "label last search" })
map("c", "<s-cr>", label_search , { desc = "label current search" })
map("c", "<c-j>", label_search , { desc = "label current search" })
