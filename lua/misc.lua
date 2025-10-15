local M = {}

function M.setup()
  vim.diagnostic.config {
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
  }

  vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")
  vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
  vim.keymap.set("n", "[p", "<Cmd>exe 'put! ' . v:register<CR>", { desc = "Paste Above" })
  vim.keymap.set("n", "]p", "<Cmd>exe 'put '  . v:register<CR>", { desc = "Paste Below" })

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
end

return M
