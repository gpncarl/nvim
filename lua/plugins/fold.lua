return {
    {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter" },
        config = function()
            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end
            })
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        end
    },
    {
        "luukvbaal/statuscol.nvim",
        event = "BufReadPost",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                relculright = true,
                segments = {
                    {
                        sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false },
                        click = "v:lua.ScSa"
                    },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                    {
                        sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = false, wrap = true },
                        -- sign = { name = { ".*" }, maxwidth = 1, auto = true, wrap = true },
                        click = "v:lua.ScSa"
                    },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                }
            })
        end,
    }
}
