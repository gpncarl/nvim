local closed = function(line) return vim.fn.foldclosed(line) >= 0 end
local opened = function(line)
  return tostring(vim.treesitter.foldexpr(line)):sub(1, 1) == ">"
end

_G.ClickFold = function()
  local mousepos = vim.fn.getmousepos()
  vim.api.nvim_set_current_win(mousepos.winid)
  vim.api.nvim_win_set_cursor(0, { mousepos.line, 0 })
  if closed(mousepos.line) then
    vim.fn.execute("norm! zo")
  elseif opened(mousepos.line) then
    vim.fn.execute("norm! zc")
  end
end

_G.StatusColumn = function()
  local hl = ""
  local text = vim.opt.fillchars:get().foldsep
  if vim.v.virtnum ~= 0 then
  elseif closed(vim.v.lnum) then
    text = vim.opt.fillchars:get().foldclose
    hl = "Folded"
  elseif opened(vim.v.lnum) then
    text = vim.opt.fillchars:get().foldopen
    if vim.v.relnum == 0 then
      hl = "CursorLineNr"
    end
  end
  return "%s%=%l %@v:lua.ClickFold@%#" .. hl .. "#" .. text .. " %*%T"
end

vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.statuscolumn = "%!v:lua.StatusColumn()"
vim.opt.conceallevel = 2
vim.opt.cmdheight = 0
vim.opt.updatetime = 100
vim.opt.fixendofline = false
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.inccommand = "nosplit"
vim.opt.mouse = "nv"
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.hlsearch = true
vim.opt.showmode = true
vim.opt.wrapscan = true
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.linebreak = true
vim.opt.cursorline = false
vim.opt.colorcolumn = ""
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.breakindentopt = ""
vim.opt.autochdir = false
vim.opt.signcolumn = "yes"
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.splitright = true
vim.opt.hidden = false
vim.opt.showmatch = true
vim.opt.cinoptions = { "g0", "j1", "l1", "N-s", "E-s", "t0", "(0", "w1", "W4" }
vim.opt.showbreak = "↪ "
vim.opt.virtualedit = "block"
vim.opt.background = "dark"
vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append({ I = true })
vim.opt.cpoptions:append({ n = true })
vim.opt.sessionoptions:append("winpos")
vim.opt.path:append("**")
vim.opt.showcmdloc = "statusline"
vim.opt.matchpairs:append({ "<:>" })
vim.opt.jumpoptions = "stack"
