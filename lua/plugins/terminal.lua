local function lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
  })
  lazygit:toggle()
end

local function glow_toggle(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local filename = opts.fargs[1]
  if filename == nil or filename == "" then
    filename = vim.fn.expand("%")
  end
  if not vim.fn.filereadable(filename) then
    vim.notify(filename .. "not readable", vim.log.levels.ERROR, { title = "toggleterm glow" })
    return
  end

  local glow = Terminal:new({
    cmd = "glow -p " .. filename,
    hidden = true,
    direction = "float",
  })
  glow:toggle()
end

return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<c-\\><c-\\>" },
      { "<leader>g",   lazygit_toggle, desc = "open lazygit" },
    },
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
      "LazyGit",
      "Glow",
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = "<c-\\><c-\\>"
      })
      vim.api.nvim_create_user_command("LazyGit", lazygit_toggle, {})
      vim.api.nvim_create_user_command("Glow", glow_toggle, { complete = "file", nargs = "?" })
    end
  },
}
