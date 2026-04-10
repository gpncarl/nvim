local NS = vim.api.nvim_create_namespace('jumph')
local LABELS = vim.split('fjdkslgha;rueiwotyqpvbcnxmzFJDKSLGHARUEIWOTYQPVBCNXMZ', '')

local cffi = require('jumph.ffi')
local ffi = cffi.ffi
local C = cffi.C
local build_regmatch = cffi.build_regmatch
local get_buf_len = cffi.get_buf_len

local M = {}

--- Check if a line should be scanned based on jump direction.
local function in_direction(lnum, cursor_lnum, forward)
  if forward == true then return lnum >= cursor_lnum end
  if forward == false then return lnum <= cursor_lnum end
  return true
end

--- Check if a line is visible (not inside a closed fold).
local function line_visible(lnum)
  local fold = vim.fn.foldclosed(lnum)
  return fold == -1 or fold == lnum
end

--- Check if a match at (lnum, col) should be kept relative to cursor.
local function match_past_cursor(match_lnum, match_col, cursor_lnum, cursor_col, forward)
  if match_lnum ~= cursor_lnum then return true end
  local offset = match_col - cursor_col
  if forward == nil then return offset ~= 0 end
  if forward then return offset > 0 end
  return offset < 0
end

--- Place a label extmark and record it.
local function place_label(bufnr, label, lnum_0, col, extmarks)
  local id = vim.api.nvim_buf_set_extmark(bufnr, NS, lnum_0, col, {
    virt_text = { { label, 'CurSearch' } },
    virt_text_pos = 'overlay',
    hl_mode = 'replace',
  })
  extmarks[label] = { line = lnum_0, col = col, id = id }
end

--- Collect all regex matches on a single line, returns next label index.
local function collect_line_matches(regm, wp, buf, lnum, bufnr, cursor_lnum, cursor_col, forward, label_idx, extmarks)
  local col = 0
  while C.vim_regexec_multi(regm, wp, buf, lnum, col, nil, nil) > 0 do
    local s, e = regm.startpos[0], regm.endpos[0]
    local s_lnum, s_col = tonumber(s.lnum), tonumber(s.col)
    local e_lnum, e_col = tonumber(e.lnum), tonumber(e.col)

    if s_lnum == 0
      and match_past_cursor(lnum, s_col, cursor_lnum, cursor_col, forward)
      and label_idx <= #LABELS
    then
      place_label(bufnr, LABELS[label_idx], lnum - 1, s_col, extmarks)
      label_idx = label_idx + 1
    end

    -- Advance past this match; break on multi-line or end-of-line
    if e_lnum > 0 then break end
    col = e_col + (col == e_col and 1 or 0)
    if col > get_buf_len(buf, lnum) then break end
  end
  return label_idx
end

local function do_jump(pat, opts)
  opts = opts or {}
  local forward = opts.forward

  local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_lnum, cursor_col = cursor[1], cursor[2]

  vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)

  local regm = build_regmatch(pat)
  if not regm then return end

  local err = ffi.new('Error')
  local buf = C.find_buffer_by_handle(bufnr, err)
  local wp = C.find_window_by_handle(winid, err)

  local label_idx = 1
  local extmarks = {}

  for lnum = vim.fn.line('w0'), vim.fn.line('w$') do
    if in_direction(lnum, cursor_lnum, forward) and line_visible(lnum) then
      label_idx = collect_line_matches(
        regm, wp, buf, lnum, bufnr,
        cursor_lnum, cursor_col, forward,
        label_idx, extmarks
      )
    end
  end

  return label_idx, extmarks
end

-- Disable JIT for the FFI-calling function
jit.off(do_jump, true)

function M.jump(pattern, opts)
  if not pattern or #pattern == 0 then return end
  opts = opts or {}

  vim.v.hlsearch = false
  local label_idx, extmarks = do_jump(pattern, opts)
  if not label_idx then return end

  vim.schedule(function()
    if label_idx >= 2 then
      local next_char = vim.fn.nr2char(vim.fn.getchar())
      local pos = extmarks[next_char]
      if pos then
        vim.cmd("normal! m'")
        vim.api.nvim_win_set_cursor(0, { pos.line + 1, pos.col })
      end
    end
    vim.api.nvim_buf_clear_namespace(0, NS, 0, -1)
  end)
end

function M.setup(opts)
  if opts and opts.labels then
    LABELS = vim.split(opts.labels, '')
  end
end

return M
