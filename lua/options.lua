_G.Statuscolumn = function()
    local stc = "%s%=%l "
    local fold = "  "
    if vim.v.virtnum ~= 0 then
        return stc .. fold
    end

    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = "%#Folded#" .. vim.opt.fillchars:get().foldclose .. " %*"
    elseif tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">" then
        if vim.v.relnum == 0 then
            fold = "%#CursorLineNr#" .. vim.opt.fillchars:get().foldopen .. " %*"
        else
            fold = vim.opt.fillchars:get().foldopen .. " "
        end
    end
    return stc .. fold
end

vim.opt.statuscolumn = "%!v:lua.Statuscolumn()"
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
vim.opt.breakindent = false
vim.opt.breakindentopt = "shift:4"
vim.opt.autochdir = false
vim.opt.signcolumn = "yes"
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.splitright = true
vim.opt.hidden = true
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
vim.opt.foldcolumn = "1"
vim.opt.foldtext = ""
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.showcmdloc = "statusline"
vim.opt.matchpairs:append({ "<:>" })
vim.opt.jumpoptions = "stack"
