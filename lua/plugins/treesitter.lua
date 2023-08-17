local function config()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

    local ts = require("nvim-treesitter.configs")

    ts.setup({
        ensure_installed = { "bash", "lua", "c", "cpp", "python", "vim", "comment" },
        indent = { enable = false },
        matchup = { enable = true, disable = {} },
        highlight = { enable = true, use_languagetree = true },
        refactor = {
            highlight_definitions = { enable = true },
            highlight_current_scope = { enable = false },
            smart_rename = { enable = true, keymaps = { smart_rename = "<leader><leader>r" } },
            navigation = { enable = true }
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        textobjects = {
            select = {
                enable = true,
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = { ["]m"] = "@function.outer",["]]"] = "@class.outer" },
                    goto_next_end = { ["]M"] = "@function.outer",["]["] = "@class.outer" },
                    goto_previous_start = { ["[m"] = "@function.outer",["[["] = "@class.outer" },
                    goto_previous_end = { ["[M"] = "@function.outer",["[]"] = "@class.outer" }
                },
                keymaps = {
                    af = "@function.outer",
                    ["if"] = "@function.inner",
                    ac = "@class.outer",
                    ic = "@class.inner"
                }
            }
        },
        rainbow = { enable = true, extended_mode = true }
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSUninstall" },
        build = ":TSUpdate",
        config = config
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "ModeChanged *:no",
        keys = { "[", "]" },
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
