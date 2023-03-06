return {
    {
        "folke/trouble.nvim",
        keys = { "<leader>t" },
        config = function()
            local t = require("trouble")
            t.setup({ icons = true })
            return vim.keymap.set("n", "<leader>t", "<Cmd>TroubleToggle<CR>", { desc = "toggle troube" })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require("lspsetting")
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup {}
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "nvim-lspconfig" },
        config = function()
            local m = require("mason-lspconfig")
            return m.setup {}
        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "mason.nvim", "null-ls.nvim" },
        config = function()
            local m = require("mason-null-ls")
            return m.setup({})
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "plenary.nvim" },
        config = function()
            local nl = require("null-ls")
            return nl.setup {
                sources = { nl.builtins.formatting.fnlfmt },
                on_attach = function(client, buffer)
                    vim.keymap.set({ "n", "v" },
                        "<space>fm",
                        vim.lsp.buf.format,
                        {
                            buffer = buffer,
                            desc = "format"
                        })
                end
            }
        end
    },
    { "j-hui/fidget.nvim", event = "LspAttach", config = true },
}
