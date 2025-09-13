M = {}

local function parseosc11(resp)
  local r, g, b
  r, g, b = resp:match('^\027%]11;rgb:(%x+)/(%x+)/(%x+)$')
  if not r and not g and not b then
    local a
    r, g, b, a = resp:match('^\027%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$')
    if not a or #a > 4 then
      return nil, nil, nil
    end
  end

  if r and g and b and #r <= 4 and #g <= 4 and #b <= 4 then
    return r, g, b
  end

  return nil, nil, nil
end

local colorstr = function(r, g, b)
  local str = '#'
  for _, v in ipairs({ r, g, b }) do
    if #v == 1 then
      str = str .. v .. v
    else
      str = str .. v:sub(1,2)
    end
  end
  return str
end

local function tmuxtrans(seq)
  return "\027Ptmux;" .. seq:gsub("\027", "\027\027") .. "\027\\"
end

local function write_seq(seq)
  if vim.env.TMUX then
    io.stdout:write(tmuxtrans(seq))
  else
    io.stdout:write(seq)
  end
end

local function bgcolor()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal == nil or normal.bg == nil then
    return nil
  end
  return string.format('#%06x', normal.bg)
end

local function sync(old, new)
  if new ~= nil and new ~= old then
    write_seq('\027]11;' .. new .. '\007')
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('TermResponse', {
    nested = true,
    callback = function(args)
      local r, g, b = parseosc11(args.data.sequence)
      if not (r and g and b) then
        return
      end

      local termbg = colorstr(r, g, b)
      sync(termbg, bgcolor())

      vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
        callback = function()
          sync(termbg, bgcolor())
        end
      })
      vim.api.nvim_create_autocmd({ 'UILeave' }, {
        callback = function()
          sync(bgcolor(), termbg)
        end
      })
    end,
  })

  write_seq('\027]11;?\007')
end

return M
