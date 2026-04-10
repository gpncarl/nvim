local NS = vim.api.nvim_create_namespace('jumph')
local LABELS = vim.split('fjdkslgha;rueiwotyqpvbcnxmzFJDKSLGHARUEIWOTYQPVBCNXMZ', '')

local cffi = require('jumph.ffi')
local ffi = cffi.ffi
local C = cffi.C
local build_regmatch = cffi.build_regmatch
local get_buf_len = cffi.get_buf_len

local M = {}

local function do_jump(pat, opts)
  opts = opts or {}
  local forward = opts.forward

  local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_lnum = cursor[1] -- 1-based
  local cursor_col = cursor[2]  -- 0-based

  local line_start = vim.fn.line('w0')
  local line_end = vim.fn.line('w$')

  vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)

  local regm = build_regmatch(pat)
  if not regm then
    return
  end

  local err = ffi.new('Error')
  local buf = C.find_buffer_by_handle(bufnr, err)
  local wp = C.find_window_by_handle(winid, err)

  local char_idx = 1
  local extmarks = {}

  for lnum = line_start, line_end do
    local skip = (forward == true and lnum < cursor_lnum)
      or (forward == false and lnum > cursor_lnum)

    if not skip and vim.tbl_contains({lnum, -1}, vim.fn.foldclosed(lnum)) then
      local col = 0
      while C.vim_regexec_multi(regm, wp, buf, lnum, col, nil, nil) > 0 do
        local s = regm.startpos[0]
        local e = regm.endpos[0]
        local s_lnum = tonumber(s.lnum)
        local s_col = tonumber(s.col)   -- 0-based
        local e_lnum = tonumber(e.lnum)
        local e_col = tonumber(e.col)

        -- Only handle matches on the current line (skip multi-line spans)
        if s_lnum == 0 then
          local match_lnum = lnum       -- 1-based
          local match_col = s_col       -- 0-based

          local keep = true
          if match_lnum == cursor_lnum then
            local offset =  match_col - cursor_col
            if forward == nil then
              keep = offset ~= 0
            elseif forward then
              keep = offset > 0
            else
              keep = offset < 0
            end
          end

          if keep and char_idx <= #LABELS then
            local overlay_char = LABELS[char_idx]
            local linenr = match_lnum - 1 -- 0-based for extmark
            local id = vim.api.nvim_buf_set_extmark(bufnr, NS, linenr, match_col, {
              virt_text = { { overlay_char, 'CurSearch' } },
              virt_text_pos = 'overlay',
              hl_mode = 'replace',
            })
            extmarks[overlay_char] = { line = linenr, col = match_col, id = id }
            char_idx = char_idx + 1
          end
        end

        -- Advance past this match
        if e_lnum > 0 then
          break
        end
        col = e_col + (col == e_col and 1 or 0)
        if col > get_buf_len(buf, lnum) then
          break
        end
      end
    end
  end

  return char_idx, extmarks
end

-- Disable JIT for the FFI-calling function
jit.off(do_jump, true)

function M.jump(pattern, opts)
  if not pattern or #pattern == 0 then
    return
  end

  vim.v.hlsearch = false
  local char_idx, extmarks = do_jump(pattern, opts)
  if not char_idx then
    return
  end

  vim.schedule(function()
    if char_idx >= 2 then
      local next_char = vim.fn.nr2char(vim.fn.getchar())
      if forward ~= nil and next_char == vim.keycode("<cr>") then
        next_char = LABELS[1]
      end
      if extmarks[next_char] then
        local pos = extmarks[next_char]
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
