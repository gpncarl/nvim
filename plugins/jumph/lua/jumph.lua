local NS = vim.api.nvim_create_namespace('jumph')

local cffi = require('jumph.ffi')
local ffi = cffi.ffi
local C = cffi.C
local build_regmatch = cffi.build_regmatch
local get_buf_len = cffi.get_buf_len

local M = {}

local function line_visible(lnum)
  local fold = vim.fn.foldclosed(lnum)
  return fold == -1 or fold == lnum
end

local function match_past_cursor(match_lnum, match_col, cursor_lnum, cursor_col, forward)
  if match_lnum ~= cursor_lnum then return true end
  local offset = match_col - cursor_col
  if forward == nil then return offset ~= 0 end
  if forward then return offset > 0 end
  return offset < 0
end

local function do_match(pat, forward)
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

  local result = {}

  local top_lnum = vim.fn.line('w0')
  local bottom_lnum = vim.fn.line('w$')
  local start_line = forward == true and cursor_lnum or top_lnum
  local end_line = forward == false and cursor_lnum or bottom_lnum

  for lnum = start_line, end_line do
    if line_visible(lnum) then
      local col = 0
      while C.vim_regexec_multi(regm, wp, buf, lnum, col, nil, nil) > 0 do
        local s, e = regm.startpos[0], regm.endpos[0]
        local s_lnum, s_col = tonumber(s.lnum), tonumber(s.col)
        local e_lnum, e_col = tonumber(e.lnum), tonumber(e.col)

        if match_past_cursor(lnum, s_col, cursor_lnum, cursor_col, forward) then
          table.insert(result, {
            pos = {lnum + s_lnum, s_col},
            end_pos = {lnum + e_lnum, e_col - 1},
          })
        end

        -- Advance past this match; break on multi-line or end-of-line
        if e_lnum > 0 then break end
        col = e_col + (col == e_col and 1 or 0)
        if col > get_buf_len(buf, lnum) then break end
      end
    end
  end
  return forward == false and vim.fn.reverse(result) or result
end

jit.off(do_match, true)

local function do_label(matchs, labels)
  local extmarks = {}
  local bufnr = vim.api.nvim_get_current_buf()
  local len = labels and math.min(#labels, #matchs) or #matchs
  for i = 1, len do
    local item = matchs[i]
    local label = labels and labels[i] or tostring(i)
    local lnum = item.pos[1]
    local col = item.pos[2]
    local id = vim.api.nvim_buf_set_extmark(bufnr, NS, lnum - 1, col, {
      virt_text = { { label, 'CurSearch' } },
      virt_text_pos = 'overlay',
      hl_mode = 'replace',
    })
    extmarks[label] = { line = lnum, col = col, id = id }
  end

  return extmarks
end

function M.count_label(pattern)
  local hls = vim.v.hlsearch
  vim.v.hlsearch = false
  local forward_matchs = do_match(pattern, true)
  local backward_matchs = do_match(pattern, false)
  do_label(forward_matchs)
  do_label(backward_matchs)

  vim.on_key(function()
    vim.on_key(nil, NS)
    vim.api.nvim_buf_clear_namespace(0, NS, 0, -1)
    vim.v.hlsearch = hls
  end, NS)
end

function M.setup(opts)
end

return M
