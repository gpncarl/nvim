local function mason_lsp_config()
    local lspconfig = require("lspconfig")
    local function on_attach(client, bufnr)
        vim.bo[bufnr].tagfunc = nil
        local function ref(opts)
            return vim.lsp.buf.references(opts, nil)
        end
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "goto define" })
        vim.keymap.set("n", "gr", ref, { buffer = bufnr, desc = "goto ref" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "goto implementation" })
        vim.keymap.set("n", "<space>ac", vim.lsp.buf.code_action, { buffer = bufnr, desc = "code action" })
        vim.keymap.set({ "n", "v" }, "<space>fm", vim.lsp.buf.format, { buffer = bufnr, desc = "format" })

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
            require("nvim-navbuddy").attach(client, bufnr)
            vim.keymap.set("n", "<space>o", require("nvim-navbuddy").open,
                { buffer = bufnr, desc = "switch header" })
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
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            {
                underline = true,
                virtual_text = true,
                signs = true,
                update_in_insert = false
            })

    local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        clangd = function()
            lspconfig.clangd.setup {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    require("clangd_extensions.inlay_hints").setup_autocmd()
                    require("clangd_extensions.inlay_hints").set_inlay_hints()
                    vim.keymap.set("n", "<space>sh", "<cmd>ClangdSwitchSourceHeader<cr>",
                        { buffer = bufnr, desc = "switch header" })
                end,
                capabilities = capabilities,
            }
        end,
        lua_ls = function()
            lspconfig.lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            }
        end
    }

    require("mason-lspconfig").setup {
        ensure_installed = { "clangd", "lua_ls" },
        handlers = handlers,
    }
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
    { "neovim/nvim-lspconfig", lazy = true },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup {}
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "folke/neodev.nvim",
            "folke/neoconf.nvim",
        },
        config = mason_lsp_config
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
        opts = {}
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
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
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {}
    },
    { "folke/neodev.nvim",     opts = {} },
    { "folke/neoconf.nvim",    opts = {} },
    {
        "smjonas/inc-rename.nvim",
        keys = { "<leader>rn" },
        config = function()
            require "inc_rename".setup {}
            vim.keymap.set("n", "<leader>rn", ":IncRename ")
        end
    },
    { "p00f/clangd_extensions.nvim", lazy = true }

}
