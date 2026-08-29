vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "CursorLineFold", { link = "CursorLine" })

MiniMisc.safely("later", function()
  require("vim._core.ui2").enable({
    enable = false,
    msg = {
      targets = "msg",
    }
  })
  vim.api.nvim_create_user_command("LspToggleInlayHint", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "toggle inlay hint" })
end)
