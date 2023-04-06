return {
    {
        "ludovicchabant/vim-gutentags",
        init = function()
            vim.g.gutentags_modules = { "ctags" }
            vim.g.gutentags_ctags_exclude = { ".ccls-cache", ".cache", ".clangd", ".vscode" }
        end
    },
}
