local M = {}

function M.setup()
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
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = require("utils.icons").diagnostics.ERROR,
        [vim.diagnostic.severity.WARN] = require("utils.icons").diagnostics.WARN,
        [vim.diagnostic.severity.INFO] = require("utils.icons").diagnostics.INFO,
        [vim.diagnostic.severity.HINT] = require("utils.icons").diagnostics.HINT,
      }
    },
  })

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  local map = vim.keymap.set

  map("t", "<c-w>", "<c-\\><c-n><c-w>")
  map("t", "<esc><esc>", "<c-\\><c-n>")
  map("n", "[p", "<cmd>exe 'put! ' . v:register<cr>", { desc = "Paste Above" })
  map("n", "]p", "<cmd>exe 'put '  . v:register<cr>", { desc = "Paste Below" })

  map("n", "<leader>ch", function()
    local ok = pcall(vim.cmd.LspClangdSwitchSourceHeader) or pcall(vim.cmd.A)
    if not ok then
      vim.notify("Failed to switch source/header", vim.log.levels.ERROR)
    end
  end, { desc = "Switch source/header" })

  local pick = require("utils.picker").pick
  local root = function() return require("utils").root() end

  map("n", "<leader>,",  function() pick("buffers") end,                                { desc = "Buffers" })
  map("n", "<leader>/",  function() pick("live_grep", { cwd = root() }) end,            { desc = "Grep(root)" })
  map("n", "<leader>fo", function() pick("treesitter") end,                             { desc = "Treesitter" })
  map("n", "<leader>fb", function() pick("buffers") end,                                { desc = "Buffers" })
  map("n", "<leader>ff", function() pick("files", { cwd = root() }) end,                { desc = "Find Files(root)" })
  map("n", "<leader>fF", function() pick("files") end,                                  { desc = "Find Files(cwd)" })
  map("n", "<leader>fr", function() pick("oldfiles") end,                               { desc = "Recent" })
  map("n", "<leader>sg", function() pick("live_grep", { cwd = root() }) end,            { desc = "Grep(root)" })
  map("n", "<leader>sG", function() pick("live_grep") end,                              { desc = "Grep(cwd)" })
  map("n", "<leader>sR", function() pick("resume") end,                                 { desc = "Resume" })
  map({ "n", "x" }, "<leader>sw", function() pick("grep_string", { cwd = root() }) end, { desc = "Selection or word(root)" })
  map({ "n", "x" }, "<leader>sW", function() pick("grep_string") end,                   { desc = "Selection or word(cwd)" })
  map("n", "gd",  function() pick("lsp_definitions") end,                               { desc = "Goto Definition" })
  map("n", "gD",  function() pick("lsp_declarations") end,                              { desc = "Goto Declaration" })
  map("n", "grr", function() pick("lsp_references") end,                                { desc = "References", nowait = true })
  map("n", "gri", function() pick("lsp_implementations") end,                           { desc = "Goto Implementation" })
  map("n", "grt", function() pick("lsp_type_definitions") end,                          { desc = "Goto Type Definition" })
  map("n", "<leader>ss", function() pick("lsp_document_symbols") end,                   { desc = "LSP Symbols" })
  map("n", "<leader>sS", function() pick("lsp_workspace_symbols") end,                  { desc = "LSP Workspace Symbols" })

  map({ "n", "x" }, "<s-cr>", function()
    require("utils.jump").count_label()
  end, { desc = "label last search" })

  map("c", "<s-cr>", function()
    vim.api.nvim_feedkeys(vim.keycode("<cr>"), "n", false)
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype == "/" or cmdtype == "?" then
      local forward = (cmdtype == "/")
      vim.schedule(function()
        require("utils.jump").count_label(forward)
      end)
    end
  end, { desc = "label current search" })
end

return M
