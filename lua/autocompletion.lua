local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local function _1_(args)
  return luasnip.lsp_expand(args.body)
end
local function _2_(fallback)
  if cmp.visible() then
    cmp.close()
  else
  end
  if luasnip.jumpable(1) then
    return luasnip.jump(1)
  else
    return nil
  end
end
local function _5_(fallback)
  if cmp.visible() then
    cmp.close()
  else
  end
  if luasnip.jumpable(-1) then
    return luasnip.jump(-1)
  else
    return nil
  end
end
local function _8_(entry, vim_item)
  vim_item.kind = lspkind.presets.default[vim_item.kind]
  vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
  vim_item.menu = ({buffer = "[B]", path = "[P]", luasnip = "[S]", nvim_lsp = "[L]", cmp_tabnine = "[T]"})[entry.source.name]
  return vim_item
end
return cmp.setup({snippet = {expand = _1_}, completion = {completeopt = "menuone,noinsert,noselect"}, mapping = cmp.mapping.preset.insert({["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.close(), ["<CR>"] = cmp.mapping.confirm({select = false}), ["<C-j>"] = cmp.mapping(_2_, {"i", "s"}), ["<C-k>"] = cmp.mapping(_5_, {"i", "s"})}), sources = {{name = "nvim_lsp"}, {name = "buffer"}, {name = "path"}, {name = "luasnip"}, {name = "cmp_tabnine"}, {name = "neorg", ft = "norg"}}, formatting = {format = _8_}, view = {entries = "native"}, experimental = {ghost_text = false}})