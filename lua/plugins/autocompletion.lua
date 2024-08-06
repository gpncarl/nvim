local function cmp_config()
  local cmp = require("cmp")
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end
    },
    completion = {
      completeopt = "menuone,noinsert,noselect",
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<S-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
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
        vim_item.kind = require("utils.icons").kinds[vim_item.kind]
        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
        vim_item.menu = ({
          buffer = "[B]",
          path = "[P]",
          snippets = "[S]",
          nvim_lsp = "[L]",
          cmp_tabnine = "[T]",
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
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "tzachar/cmp-tabnine",
      "garymjr/nvim-snippets",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = cmp_config
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
  },
  {
    "garymjr/nvim-snippets",
    lazy = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      friendly_snippets = true,
      ignored_filetypes = { "norg" },
      global_snippets = { "all", "global" },
    },
  }
}
