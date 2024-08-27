local config = require("config")
local function cmp_config()
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    completion = {
      completeopt = "menuone,noinsert,noselect",
    },
    mapping = {
      ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<c-u>"] = cmp.mapping.scroll_docs(-4),
      ["<c-d>"] = cmp.mapping.scroll_docs(4),
      ["<c-space>"] = cmp.mapping.complete(),
      ["<c-e>"] = cmp.mapping.abort(),
      ["<cr>"] = cmp.mapping.confirm({ select = true }),
      ["<c-cr>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<s-cr>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
      ["<tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<s-tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "copilot" },
      { name = "supermaven" },
      { name = "path" },
      { name = "snippets" },
      { name = "cmp_tabnine" },
      { name = "neorg",      ft = "norg" },
      { name = "orgmode",    ft = "org" },
      { name = "lazydev",    ft = "lua", group_index = 0 },
    },

    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = require("mini.icons").get("lsp", vim_item.kind)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
        vim_item.menu = ({
          buffer = "[B]",
          path = "[P]",
          snippets = "[S]",
          nvim_lsp = "[L]",
          cmp_tabnine = "[T]",
          copilot = "[C]",
          supermaven = "[M]",
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
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" }
    }
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" }
    }, {
      { name = "cmdline" }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return {
  {
    "echasnovski/mini.pairs",
    event = { "InsertEnter" },
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      {
        "garymjr/nvim-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
          friendly_snippets = true,
          ignored_filetypes = { "norg" },
          global_snippets = { "all", "global" },
        },
      },
      {
        "tzachar/cmp-tabnine",
        build = "bash install.sh",
      },
      {
        "zbirenbaum/copilot-cmp",
        cond = config.copilot,
        dependencies = {
          {
            "zbirenbaum/copilot.lua",
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
            },
          }
        },
        opts = {}
      },
      {
        "supermaven-inc/supermaven-nvim",
        opts = {
          log_level = "warn",
          disable_keymaps = true,
          disable_inline_completion = true,
        },
        config = function(_, opts)
          vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
          require("supermaven-nvim").setup(opts)
        end,
      },
    },
    config = cmp_config
  },
}
