local function cmp_config()
    local cmp = require('cmp')
    local luasnip = require("luasnip")
    cmp.setup {
        snippet = {
            expand = function(args)
                require 'luasnip'.lsp_expand(args.body)
            end
        },
        completion = {
            completeopt = 'menuone,noinsert,noselect',
        },

        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                end
            end, { "i", "s" }),
            ["<C-k>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        },

        sources = {
            { name = 'nvim_lsp' },
            -- { name = 'copilot' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'cmp_tabnine' },
            { name = 'neorg',      ft = 'norg' },
        },

        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = require("utils.icons").kinds[vim_item.kind]
                vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
                vim_item.menu = ({
                    buffer = "[B]",
                    path = "[P]",
                    luasnip = "[S]",
                    nvim_lsp = "[L]",
                    cmp_tabnine = "[T]",
                    -- copilot = "[C]",
                })[entry.source.name]
                return vim_item
            end,
        },

        view = {
            -- entries = "native",
        },

        experimental = {
            ghost_text = false,
        }
    }
end

return {
    { "hrsh7th/cmp-path",             lazy = true },
    { "hrsh7th/cmp-buffer",           lazy = true },
    { "hrsh7th/cmp-nvim-lsp",         lazy = true },
    { "rafamadriz/friendly-snippets", lazy = true },
    {
        "tzachar/cmp-tabnine",
        build = "bash install.sh",
        lazy = true
    },
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
        dependencies = { "L3MON4D3/LuaSnip" }
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local loader = require("luasnip/loaders/from_vscode")
            local ls = require("luasnip")
            loader.lazy_load()
            return ls.setup({ history = true, delete_check_events = "TextChanged" })
        end
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        dependencies = { "zbirenbaum/copilot.lua" },
        opts = {}
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "tzachar/cmp-tabnine",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            -- "zbirenbaum/copilot-cmp",
        },
        config = cmp_config
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local ap = require("nvim-autopairs")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            ap.setup({ disable_filetype = { "TelescopePrompt", "vim" }, enable_check_bracket_line = false })
            return (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
        end
    },
}
