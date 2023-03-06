require("options")

_G.dump = function(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    return print(unpack(objects))
end
local function switchHeader()
    local alt_exts = { c = { "h" }, cpp = { "h", "hpp" }, cc = { "h", "hpp" }, hpp = { "cc", "cpp" },
        h = { "cc", "cpp", "c" } }
    local ext = vim.fn.expand("%:e")
    local basename = vim.fn.expand("%:t:r")
    local alt_ext = alt_exts[ext]
    local pattern_ext = vim.fn.join(alt_ext, "|")
    local cmdstring = ("fd -tf -1 --strip-cwd-prefix -s \"^" .. basename .. "\\.(" .. pattern_ext .. ")$\"|xargs printf %s")
    local pathname = vim.fn.system(cmdstring)
    if (pathname == "") then
        return vim.fn.throw("pathname is empty")
    elseif (vim.fn.bufexists(pathname) == 1) then
        return vim.fn.execute(("buffer " .. pathname), "slient")
    else
        return vim.fn.execute(("edit " .. pathname), "slient")
    end
end

local function _2_()
    vim.opt.hlsearch = true
    return nil
end

vim.api.nvim_create_autocmd("FileType", { pattern = { "text" }, callback = _2_ })
vim.api.nvim_create_autocmd("QuickFixCmdPre", { command = "packadd cfilter" })
local nmap
local function _3_(...)
    return vim.keymap.set("n", ...)
end
nmap = _3_
nmap("<space>sd", "<Cmd>!sdcv <cword><CR>", { desc = "sdcv dict" })
nmap("<space>sh", switchHeader, { desc = "switch header" })
nmap("K", vim.diagnostic.open_float, { desc = "current line diagnostic" })
local _5_
do
    local _4_ = { float = false }
    local function _6_(...)
        return vim.diagnostic.goto_prev(_4_, ...)
    end
    _5_ = _6_
end
nmap("[g", _5_, { desc = "goto previous diagnostic" })
local _8_
do
    local _7_ = { float = false }
    local function _9_(...)
        return vim.diagnostic.goto_next(_7_, ...)
    end
    _8_ = _9_
end
nmap("]g", _8_, { desc = "goto next diagnostic" })
local tmap
local function _10_(...)
    return vim.keymap.set("t", ...)
end
tmap = _10_
tmap("<c-w>", "<c-\\><c-n><c-w>")
nmap("<leader>g", vim.diagnostic.setqflist, { desc = "goto define" })

vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_winsize = 20
vim.g.netrw_altfile = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
