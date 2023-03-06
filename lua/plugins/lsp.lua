local function lsp_config()
    local lspconfig = require("lspconfig")
    local function on_attach(client, bufnr)
        local function ref(opts)
            return vim.lsp.buf.references(opts, nil)
        end
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "goto define" })
        vim.keymap.set("n", "gr", ref, { buffer = bufnr, desc = "goto ref" })
        vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "code action" })
        vim.keymap.set({ "n", "v" }, "<space>fm", vim.lsp.buf.format, { buffer = bufnr, desc = "format" })
        if (client.name == "clangd") then
            return vim.keymap.set("n", "<space>sh", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = bufnr, desc = "switch header" })
        end
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } }
    }
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            {
                underline = true,
                virtual_text = true,
                signs = true,
                update_in_insert = false
            })
    lspconfig.hls.setup({ autostart = true, on_attach = on_attach })
    lspconfig.pylsp.setup({ autostart = true, on_attach = on_attach, capabilities = capabilities })
    lspconfig.clangd.setup({
        autostart = true,
        filetypes = { "c", "cpp" },
        on_attach = on_attach,
        capabilities = capabilities
    })
    lspconfig.rust_analyzer.setup({ autostart = true, on_attach = on_attach, capabilities = capabilities })
    lspconfig.gopls.setup({ autostart = true, on_attach = on_attach, capabilities = capabilities })
    lspconfig.lua_ls.setup({
        autostart = true,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    })
    return lspconfig.neocmake.setup({ autostart = true, on_attach = on_attach, capabilities = capabilities })
end

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
        config = lsp_config
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
                on_attach = function(_, buffer)
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
