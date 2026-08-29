MiniMisc.safely("later", function()
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

  map("n", "<leader>,", function() pick("buffers") end, { desc = "Buffers" })
  map("n", "<leader>/", function() pick("live_grep", { cwd = vim.fn.getcwd() }) end, { desc = "Grep" })
  map("n", "<leader>fo", function() pick("treesitter") end, { desc = "Treesitter" })
  map("n", "<leader>fb", function() pick("buffers") end, { desc = "Buffers" })
  map("n", "<leader>ff", function() pick("files", { cwd = vim.fn.getcwd() }) end, { desc = "Find Files" })
  map("n", "<leader>fr", function() pick("oldfiles") end, { desc = "Recent" })
  map("n", "<leader>sg", function() pick("live_grep", { cwd = vim.fn.getcwd() }) end, { desc = "Grep" })
  map("n", "<leader>sR", function() pick("resume") end, { desc = "Resume" })
  map({ "n", "x" }, "<leader>sw", function() pick("grep_string", { cwd = vim.fn.getcwd() }) end,
    { desc = "Selection or word" })

  map("n", "gd", function() pick("lsp_definitions") end, { desc = "Goto Definition" })
  map("n", "gD", function() pick("lsp_declarations") end, { desc = "Goto Declaration" })
  map("n", "grr", function() pick("lsp_references") end, { desc = "Goto References", })
  map("n", "gri", function() pick("lsp_implementations") end, { desc = "Goto Implementation" })
  map("n", "grt", function() pick("lsp_type_definitions") end, { desc = "Goto Type Definition" })
  map("n", "<leader>ss", function() pick("lsp_document_symbols") end, { desc = "LSP Symbols" })
  map("n", "<leader>sS", function() pick("lsp_workspace_symbols") end, { desc = "LSP Workspace Symbols" })
end)
