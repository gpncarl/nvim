return {
    {
        "ludovicchabant/vim-gutentags",
        cmd = { "GutentagsUpdate", "GutentagsToggleEnabled" },
        init = function()
            vim.g.gutentags_enabled = false
            vim.g.gutentags_define_advanced_commands = true
            vim.g.gutentags_modules = { "ctags" }
            vim.g.gutentags_ctags_exclude = { ".ccls-cache", ".cache", ".clangd", ".vscode" }
        end
    },
}
