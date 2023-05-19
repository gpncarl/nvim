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

vim.api.nvim_create_autocmd("QuickFixCmdPre", { command = "packadd cfilter" })
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
vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")
vim.keymap.set("n", "<leader>g", vim.diagnostic.setqflist, { desc = "diagnostics" })

vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_winsize = 20
vim.g.netrw_altfile = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
