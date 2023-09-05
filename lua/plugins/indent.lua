return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = {
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
            buftype_exclude = { "terminal" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = true
        }
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- symbol = "▏",
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
