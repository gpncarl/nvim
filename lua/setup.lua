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

vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_winsize = 20
vim.g.netrw_altfile = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.mapleader = nil
vim.g.maplocalleader = nil
