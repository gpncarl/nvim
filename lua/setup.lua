local function switchHeader()
    local alt_exts = {
        c = { "h" },
        cpp = { "h", "hpp" },
        cc = { "h", "hpp" },
        hpp = { "cc", "cpp" },
        h = { "cc", "cpp", "c" }
    }
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

vim.keymap.set("n", "<space>sh", switchHeader, { desc = "switch header" })

vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        severity = {
            vim.diagnostic.severity.ERROR,
        }
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = require("utils.icons").diagnostics.ERROR,
            [vim.diagnostic.severity.WARN] = require("utils.icons").diagnostics.WARN,
            [vim.diagnostic.severity.INFO] = require("utils.icons").diagnostics.INFO,
            [vim.diagnostic.severity.HINT] = require("utils.icons").diagnostics.HINT,
        }
    },
}

vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")

vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_winsize = 20
vim.g.netrw_altfile = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.mapleader = nil
vim.g.maplocalleader = nil
