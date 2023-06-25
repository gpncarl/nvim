local function hop_config()
    local hop = require("hop")
    hop.setup({ keys = "etovxqpdygfblzhckisuran" })

    local hint = require("hop.hint")
    vim.keymap.set("",
        "<leader><leader>F",
        function()
            hop.hint_char1 { direction = hint.HintDirection.BEFORE_CURSOR }
        end,
        { desc = "search one char before cursor" })
    vim.keymap.set("",
        "<leader><leader>f",
        function()
            hop.hint_char1 { direction = hint.HintDirection.AFTER_CURSOR }
        end,
        { desc = "search one char after cursor" })
    vim.keymap.set("",
        "<leader><leader>S",
        function()
            hop.hint_char2 { direction = hint.HintDirection.BEFORE_CURSOR }
        end,
        { desc = "search two char before cursor" })
    vim.keymap.set("",
        "<leader><leader>s",
        function()
            hop.hint_char2 { direction = hint.HintDirection.AFTER_CURSOR }
        end,
        { desc = "search two char after cursor" })
    vim.keymap.set("",
        "<leader><leader>w",
        function()
            hop.hint_words { direction = hint.HintDirection.AFTER_CURSOR, hint_position = hint.HintPosition.BEGIN }
        end,
        { desc = "word begin after cursor" })
    vim.keymap.set("",
        "<leader><leader>b",
        function()
            hop.hint_words { direction = hint.HintDirection.BEFORE_CURSOR, hint_position = hint.HintPosition.BEGIN }
        end,
        { desc = "word begin before cursor" })
    vim.keymap.set("",
        "<leader><leader>e",
        function()
            hop.hint_words { direction = hint.HintDirection.AFTER_CURSOR, hint_position = hint.HintPosition.END }
        end,
        { desc = "word end after cursor" })
    vim.keymap.set("",
        "<leader><leader>ge",
        function()
            hop.hint_words { direction = hint.HintDirection.BEFORE_CURSOR, hint_position = hint.HintPosition.END }
        end,
        { desc = "word end before cursor" })
    vim.keymap.set("", "<leader><leader>q", hop.hint_patterns, { desc = "query" })
    vim.keymap.set("",
        "<leader><leader>j",
        function()
            hop.hint_lines { direction = hint.HintDirection.AFTER_CURSOR }
        end,
        { desc = "line start after cursor" })
    vim.keymap.set("",
        "<leader><leader>k",
        function()
            hop.hint_lines { direction = hint.HintDirection.BEFORE_CURSOR }
        end,
        { desc = "line start before cursor" })
    vim.keymap.set("",
        "<leader><leader>J",
        function()
            hop.hint_lines_skip_whitespace { direction = hint.HintDirection.AFTER_CURSOR }
        end,
        { desc = "line head after cursor" })
    vim.keymap.set("",
        "<leader><leader>K",
        function()
            hop.hint_lines_skip_whitespace { direction = hint.HintDirection.BEFORE_CURSOR }
        end,
        { desc = "line head before cursor" })
end

return {
    {
        "phaazon/hop.nvim",
        keys = "<leader><leader>",
        config = hop_config
    },
    {
        "ggandor/leap.nvim",
        lazy = true,
        dependencies = { "tpope/vim-repeat", "ggandor/leap-spooky.nvim" },
        config = function()
            local l = require("leap")
            l.opts.safe_labels = {}
            l.add_default_mappings()
        end
    },
    {
        "ggandor/leap-spooky.nvim",
        lazy = true,
        opts = {}
    },
    {
        "ggandor/flit.nvim",
        lazy = true,
        opts = {}
    },
    {
        "bkad/CamelCaseMotion",
        -- event = "ModeChanged *:no",
        -- keys = { "<leader>w", "<leader>b", "<leader>e", "<leader>ge" },
        init = function()
            vim.g.camelcasemotion_key = "<leader>"
            return nil
        end
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
        },
    }
}
