local NS = vim.api.nvim_create_namespace("jump")

local do_match = function(pat, forward)
  local matchs = {}
  local cursor = vim.api.nvim_win_get_cursor(0)
  local flag = forward and "Wz" or "Wb"
  local stopline = forward and vim.fn.line("w$") or vim.fn.line("w0")
  while true do
    local pos = vim.fn.searchpos(pat, flag, stopline)
    local lnum, col = pos[1], pos[2]
    if lnum == 0 and col == 0 then
      break
    end
    table.insert(matchs, { lnum - 1, col - 1 })
  end
  vim.api.nvim_win_set_cursor(0, cursor)
  return matchs
end

local do_label = function(matchs)
  for i, pos in ipairs(matchs) do
    vim.api.nvim_buf_set_extmark(0, NS, pos[1], pos[2], {
      virt_text = { { tostring(i), "CurSearch" } },
      virt_text_pos = "overlay",
      hl_mode = "replace",
    })
  end
end

local count_label = function(forward)
  local pattern = vim.fn.getreg("/")
  local hls = vim.v.hlsearch
  vim.v.hlsearch = false

  if forward ~= false then
    do_label(do_match(pattern, true))
  end
  if forward ~= true then
    do_label(do_match(pattern, false))
  end

  vim.on_key(function()
    vim.on_key(nil, NS)
    vim.api.nvim_buf_clear_namespace(0, NS, 0, -1)
    vim.v.hlsearch = hls
  end, NS)
end

local label_search = function()
  vim.api.nvim_feedkeys(vim.keycode("<cr>"), "n", false)
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype == "/" or cmdtype == "?" then
    local forward = (cmdtype == "/")
    vim.schedule(function()
      count_label(forward)
    end)
  end
end

local map = vim.keymap.set
map({ "n", "x" }, "<s-cr>", count_label, { desc = "label last search" })
map({ "n", "x" }, "<c-j>", count_label, { desc = "label last search" })
map("c", "<s-cr>", label_search, { desc = "label current search" })
map("c", "<c-j>", label_search, { desc = "label current search" })
