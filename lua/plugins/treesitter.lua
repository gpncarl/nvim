local config = require("config")
return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSUninstall" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "lua", "c", "cpp", "python", "vim", "comment", "vimdoc" },
            indent = { enable = false },
            highlight = { enable = true, use_languagetree = true },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = false },
                smart_rename = { enable = true, keymaps = { smart_rename = "<leader><leader>r" } },
                navigation = { enable = true }
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = "<TAB>",
                    node_decremental = "<S-TAB>",
                },
            },
        },
        config = function(_, opts)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "ModeChanged *:no",
        keys = { "[", "]" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner"
                }
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
                goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
                goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
                goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
                goto_next = { ["]e"] = "@conditional.outer", },
                goto_previous = { ["[e"] = "@conditional.outer", },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup({ textobjects = opts })

            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "ModeChanged *:no",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
}
