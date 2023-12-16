return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                    "fzf",
                    "starter",
                },
            },
        },
        -- config = function(_, opts)
        --     require "ibl".setup(opts)
        --     local hooks = require "ibl.hooks"
        --     hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        --     hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
        -- end
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                    "fzf",
                    "starter",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "tpope/vim-sleuth",
        cmd = { "Sleuth" },
        config = function()
            vim.g.sleuth_heuristics = 0
        end
    }
}
