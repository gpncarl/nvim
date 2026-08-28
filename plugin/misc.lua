vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })

MiniMisc.safely("later", function()
  require("vim._core.ui2").enable({
    enable = false,
    msg = {
      targets = "msg",
    }
  })
  local diagnostic_opts = {
    jump = {},
    underline = {},
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
      current_line = true,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      },
    },
  }
  require("utils.diagnostic").setup(diagnostic_opts, vim.diagnostic.severity.ERROR)
  require("utils.timer").setup()
  vim.api.nvim_create_user_command("LspToggleInlayHint", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "toggle inlay hint" })
end)
