local function lsp_setup()
    local lspconfig = require("lspconfig")
    local function on_attach(client, bufnr)
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
            local refresh = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end
            refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = refresh,
            })
        end
    end

    local default_opts = {
        inlay_hints = { enabled = true, },
        codelens = { enabled = true, },
        document_highlight = { enabled = true, },
        format = {
            formatting_options = nil,
            timeout_ms = nil,
        },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = on_attach,
    }

    require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
        handlers = {
            function(server_name) lspconfig[server_name].setup(default_opts) end,
            clangd = function()
                lspconfig.clangd.setup(vim.tbl_extend("force", default_opts, {
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        require("clangd_extensions").setup()
                        vim.keymap.set("n", "<space>sh", "<cmd>ClangdSwitchSourceHeader<cr>",
                            { buffer = bufnr, desc = "switch header" })
                    end,
                }))
            end,
            lua_ls = function()
                lspconfig.lua_ls.setup(vim.tbl_extend("force", default_opts, {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            codeLens = { enable = true, }
                        }
                    }
                }))
            end
        }
    })
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
        opts = {}
    },
    {
        "jay-babu/mason-null-ls.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        opts = {}
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
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
        tag = "legacy",
        event = "LspAttach",
        opts = {}
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta",        lazy = true },
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {}
    },
    { "p00f/clangd_extensions.nvim", lazy = true },
}
