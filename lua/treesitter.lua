vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 2
vim.opt.foldenable = false

local ts = require("nvim-treesitter.configs")

ts.setup({
    ensure_installed = { "bash", "lua", "json", "c", "cpp", "python", "haskell", "vim", "cmake", "make", "comment", "fennel" },
    indent = { enable = false },
    matchup = { enable = true, disable = {} },
    highlight = { enable = true, use_languagetree = true },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        smart_rename = { enable = true, keymaps = { smart_rename = "<leader><leader>r" } },
        navigation = { enable = true }
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
                goto_previous_end = { ["[M"] = "@function.outer",["[]"] = "@class.outer" } },
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
