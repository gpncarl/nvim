(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local lspkind (require :lspkind))
(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :completion {:completeopt "menuone,noinsert,noselect"}
            :mapping (cmp.mapping.preset.insert {:<C-p> (cmp.mapping.select_prev_item)
                                                 :<C-n> (cmp.mapping.select_next_item)
                                                 :<C-d> (cmp.mapping.scroll_docs -4)
                                                 :<C-f> (cmp.mapping.scroll_docs 4)
                                                 :<C-Space> (cmp.mapping.complete)
                                                 :<C-e> (cmp.mapping.close)
                                                 :<CR> (cmp.mapping.confirm {:select false})
                                                 :<C-j> (cmp.mapping (fn [fallback]
                                                                       (when (cmp.visible)
                                                                         (cmp.close))
                                                                       (when (luasnip.jumpable 1)
                                                                         (luasnip.jump 1)))
                                                                     [:i :s])
                                                 :<C-k> (cmp.mapping (fn [fallback]
                                                                       (when (cmp.visible)
                                                                         (cmp.close))
                                                                       (when (luasnip.jumpable -1)
                                                                         (luasnip.jump -1)))
                                                                     [:i :s])})
            :sources [{:name :nvim_lsp}
                      {:name :buffer}
                      {:name :path}
                      {:name :luasnip}
                      {:name :cmp_tabnine}
                      {:name :neorg :ft :norg}]
            :formatting {:format (fn [entry vim_item]
                                   (set vim_item.kind
                                        (. lspkind.presets.default
                                           vim_item.kind))
                                   (set vim_item.abbr
                                        (string.sub vim_item.abbr 1 20))
                                   (set vim_item.menu
                                        (. {:buffer "[B]"
                                            :path "[P]"
                                            :luasnip "[S]"
                                            :nvim_lsp "[L]"
                                            :cmp_tabnine "[T]"}
                                           entry.source.name))
                                   vim_item)}
            :view {:entries :native}
            :experimental {:ghost_text false}})
