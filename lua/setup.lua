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
vim.keymap.set("n", "K", vim.diagnostic.open_float, { desc = "current line diagnostic" })
vim.keymap.set("n",
    "[g",
    function()
        vim.diagnostic.goto_prev { float = false }
    end,
    { desc = "goto previous diagnostic" })
vim.keymap.set("n",
    "]g",
    function()
        vim.diagnostic.goto_next { float = false }
    end,
    { desc = "goto next diagnostic" })

for name, icon in pairs(require("utils.icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
}

vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")

local quickfix = vim.api.nvim_create_augroup('quickfix', { clear = true })
vim.api.nvim_create_autocmd("QuickFixCmdPre", {
    group = quickfix,
    command = "packadd cfilter"
})

HasStdin = false
local stdin = vim.api.nvim_create_augroup('stdin', { clear = true })
vim.api.nvim_create_autocmd("StdinReadPre", {
    group = stdin,
    callback = function()
        HasStdin = true
    end
})

local config = require "config"
local enter = vim.api.nvim_create_augroup('enter', { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = enter,
    callback = function()
        if HasStdin then
            return
        end

        local argc = vim.fn.argc()
        if argc == 0 then
            if config.dashboard == "alpha" then
                vim.cmd "Alpha"
            elseif config.dashboard == "mini.starter" then
                require "mini.starter".open()
            end
        end

        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.api.nvim_exec_autocmds("User", { pattern = "OpenDirectory" })
        end
    end
})

vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_winsize = 20
vim.g.netrw_altfile = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
