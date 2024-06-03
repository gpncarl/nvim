local function lsp_setup()
    local lspconfig = require("lspconfig")
    local function on_attach(client, bufnr)
        vim.bo[bufnr].tagfunc = nil
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "goto define" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "goto declaration" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "goto ref" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "goto implementation" })
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr, desc = "code action" })
        vim.keymap.set({ "n", "v" }, "<space>fm", vim.lsp.buf.format, { buffer = bufnr, desc = "format" })
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "rename" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "code hover" })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "code signature" })

        if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client.supports_method("textDocument/codeLens") then
            vim.lsp.codelens.refresh()
            --- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
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

    local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
                inlay_hints = { enabled = true, },
                codelens = { enabled = true, },
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        clangd = function()
            lspconfig.clangd.setup {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    require("clangd_extensions").setup()
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
                        },
                        codeLens = {
                            enable = true,
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
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "folke/neoconf.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = lsp_setup
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
        build = ":MasonUpdate",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {}
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                "luvit-meta/library",
            },
        },
    },
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        dependencies = { "nvim-lspconfig" },
        opts = {}
    },
    { "p00f/clangd_extensions.nvim", lazy = true },
}
