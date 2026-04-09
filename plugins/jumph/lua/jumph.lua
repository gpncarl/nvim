local NS = vim.api.nvim_create_namespace('jumph')
local LABELS = vim.split('fjdkslgha;rueiwotyqpvbcnxmzFJDKSLGHARUEIWOTYQPVBCNXMZ', '')

local M = {}

function M.jump(pattern, forward)
  if not pattern or #pattern == 0 then
    return
  end

  vim.v.hlsearch = false
  local bufnr = vim.api.nvim_get_current_buf()
  local line_idx_start, line_idx_end = vim.fn.line('w0'), vim.fn.line('w$')
  vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)

  local char_idx = 1
  local extmarks = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_idx_start - 1, line_idx_end, false)
  local is_case_sensitive = pattern ~= string.lower(pattern)

  for lines_i, line_text in ipairs(lines) do
    local search_line = is_case_sensitive and line_text or string.lower(line_text)
    local search_pattern = is_case_sensitive and pattern or string.lower(pattern)
    local line_idx = lines_i + line_idx_start - 1

    local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))

    local skip = (forward == true and line_idx < cursor_line) or (forward == false and line_idx > cursor_line)

    if not skip and vim.tbl_contains({line_idx, -1}, vim.fn.foldclosed(line_idx)) then
      local col = 1
      while true do
        local start, stop = search_line:find(search_pattern, col, true)
        if not start then
          break
        end
        col = stop + 1

        local keep_match = function()
          if line_idx ~= cursor_line then
            return true
          end
          local offset = start - 1 - cursor_col
          if forward == nil then
            return offset ~= 0
          elseif forward then
            return offset > 0
          else
            return offset < 0
          end
        end

        if keep_match() and char_idx <= #LABELS then
          local overlay_char = LABELS[char_idx]
          local linenr = line_idx_start + lines_i - 2
          local id = vim.api.nvim_buf_set_extmark(bufnr, NS, linenr, start - 1, {
            virt_text = { { overlay_char, 'CurSearch' } },
            virt_text_pos = 'overlay',
            hl_mode = 'replace',
          })
          extmarks[overlay_char] = { line = linenr, col = start - 1, id = id }
          char_idx = char_idx + 1
        end
      end
    end
  end

  vim.schedule(function()
    if char_idx == 2 then
      local pos = extmarks[LABELS[1]]
      vim.cmd("normal! m'")
      vim.api.nvim_win_set_cursor(0, { pos.line + 1, pos.col })
    elseif char_idx > 2 then
      local next_char = vim.fn.nr2char(vim.fn.getchar())
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
