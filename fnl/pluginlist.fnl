(local plists
       {:rktjmp/hotpot.nvim {:enable false}
        :stevearc/oil.nvim {:config #(let [oil (require :oil)]
                                       (oil.setup {})
                                       (vim.keymap.set :n "-" oil.open
                                                       {:desc "Open parent directory"}))}
        :kylechui/nvim-surround {:event :VeryLazy :config {}}
        :nvim-tree/nvim-web-devicons {:lazy true}
        :navarasu/onedark.nvim {:enabled false
                                :lazy false
                                :priority 1000
                                :config #(vim.cmd "colorscheme onedark")}
        :tpope/vim-unimpaired {:event :VeryLazy}
        :tpope/vim-repeat {:event :VeryLazy}
        :tpope/vim-rsi {:event :VeryLazy}
        :tpope/vim-sleuth {:event :VeryLazy}
        :tpope/vim-abolish {:event :CmdlineEnter}
        :akinsho/toggleterm.nvim {:keys "<c-\\><c-\\>"
                                  :config #(let [term (require :toggleterm)]
                                             (term.setup {:open_mapping "<c-\\><c-\\>"}))}
        :SmiteshP/nvim-gps {:lazy true
                            :config #(let [gps (require :nvim-gps)]
                                       (gps.setup))}
        :folke/which-key.nvim {:event :VeryLazy
                               :config #(let [wk (require :which-key)]
                                          (wk.setup {:plugins {:presets {:operators false
                                                                         :motions false
                                                                         :text_objects false}}}))}
        :phaazon/hop.nvim {:keys :<leader><leader>
                           :config #(let [h (require :hop)]
                                      (h.setup {:keys :etovxqpdygfblzhckisuran})
                                      (require :hop_keymap))}
        :ggandor/leap.nvim {:enabled false
                            :event :BufRead
                            :dependencies [:vim-repeat :leap-spooky]
                            :config #(let [l (require :leap)]
                                       (l.add_default_mappings))}
        :ggandor/leap-spooky.nvim {:enabled false
                                   :name :leap-spooky
                                   :lazy true
                                   :config #(let [l (require :leap-spooky)]
                                              (l.setup))}
        :ggandor/flit.nvim {:enabled false
                            :lazy true
                            :config #(let [f (require :flit)]
                                       (f.setup))}
        :bkad/CamelCaseMotion {:event :BufRead
                               :init #(set vim.g.camelcasemotion_key :<leader>)}
        :tpope/vim-fugitive {:event :BufRead
                             ;; config (partial set vim.opt.statusline "%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P")
                             }
        :lewis6991/gitsigns.nvim {:event :BufRead
                                  :config #(let [gs (require :gitsigns)]
                                             (gs.setup {:attach_to_untracked false}))}
        :wellle/targets.vim {:event :VeryLazy}
        :antoinemadec/FixCursorHold.nvim {:event :VeryLazy}
        :nvim-lua/plenary.nvim {:lazy true}
        :nvim-lua/popup.nvim {:lazy true}
        :RRethy/vim-illuminate {:enabled false}
        :preservim/tagbar {:enabled false}
        :godlygeek/tabular {:enabled false}
        :mbbill/undotree {:enabled false}
        :onsails/lspkind-nvim {:lazy true}
        :hrsh7th/cmp-path {:lazy true}
        :hrsh7th/cmp-buffer {:lazy true}
        :hrsh7th/cmp-nvim-lsp {:lazy true}
        :saadparwaiz1/cmp_luasnip {:lazy true}
        :MunifTanjim/nui.nvim {:lazy true}
        :rcarriga/nvim-notify {:lazy true :config {:top_down false}}
        :folke/noice.nvim {:enabled false
                           :config #(let [n (require :noice)]
                                      (n.setup {}))
                           :dependencies [:nvim-notify
                                          :nui.nvim
                                          :nvim-treesitter]}
        :j-hui/fidget.nvim {:event :LspAttach
                            :config #(let [f (require :fidget)]
                                       (f.setup {}))}
        :mfussenegger/nvim-dap {:enabled false :config #(require :dapsetting)}
        :tzachar/cmp-tabnine {:build :./install.sh :lazy true}
        :nvim-neo-tree/neo-tree.nvim {:keys [{1 :<space>ft
                                              2 "<cmd>Neotree toggle<cr>"
                                              :mode :n
                                              :desc "Neotree toggle"}
                                             {1 :<space>fb
                                              2 "<cmd>Neotree buffers toggle<cr>"
                                              :mode :n
                                              :desc "Neotree buffers toggle"}]
                                      :config {:buffers {:follow_current_file true
                                                         :group_empty_dirs true
                                                         :show_unloaded true}
                                               :filesystem {:hijack_netrw_behavior :disabled}}}
        :stevearc/aerial.nvim {:enabled false}
        :rafamadriz/friendly-snippets {:lazy true}
        :L3MON4D3/LuaSnip {:lazy true
                           :config #(let [loader (require :luasnip/loaders/from_vscode)
                                          ls (require :luasnip)]
                                      (loader.lazy_load)
                                      (ls.setup {:history true
                                                 :delete_check_events :TextChanged}))
                           :dependencies [:friendly-snippets]}
        :hrsh7th/nvim-cmp {:event :InsertEnter
                           :config #(require :autocompletion)
                           :dependencies [:lspkind-nvim
                                          :cmp-path
                                          :cmp-buffer
                                          :cmp-tabnine
                                          :cmp_luasnip
                                          :cmp-nvim-lsp]}
        :numToStr/Comment.nvim {:event :VeryLazy
                                :config #(let [c (require :Comment)]
                                           (c.setup {}))}
        :ludovicchabant/vim-gutentags {:event :VeryLazy
                                       :init #(and (set vim.g.gutentags_modules
                                                        [:ctags])
                                                   (set vim.g.gutentags_ctags_exclude
                                                        [:.ccls-cache
                                                         :.cache
                                                         :.clangd
                                                         :.vscode]))}
        :ellisonleao/gruvbox.nvim {:enabled true
                                   :lazy false
                                   :priority 1000
                                   :config #(let [gruvbox (require :gruvbox)]
                                              (gruvbox.setup {:undercurl true
                                                              :underline true
                                                              :bold true
                                                              :italic false
                                                              :strikethrough true
                                                              :invert_selection false
                                                              :invert_signs false
                                                              :invert_tabline false
                                                              :invert_intend_guides false
                                                              :inverse true
                                                              :contrast ""
                                                              :overrides {}})
                                              (vim.cmd "colorscheme gruvbox"))}
        :hoob3rt/lualine.nvim {:config #(require :statusline)}
        :goolord/alpha-nvim {:cond #(= (vim.fn.argc) 0)
                             :config #(let [alpha (require :alpha)
                                            startify (require :alpha.themes.startify)]
                                        (set startify.nvim_web_devicons.enabled
                                             true)
                                        (alpha.setup startify.config))
                             :dependencies [:nvim-web-devicons]}
        :folke/trouble.nvim {:event :DiagnosticChanged
                             :config #(let [t (require :trouble)]
                                        (t.setup {:icons true})
                                        (vim.keymap.set :n :<leader>t
                                                        :<Cmd>TroubleToggle<CR>
                                                        {:desc "toggle troube"}))}
        :neovim/nvim-lspconfig {:config #(require :lspsetting)}
        :jose-elias-alvarez/null-ls.nvim {:event :VeryLazy
                                          :config #(let [nl (require :null-ls)]
                                                     (nl.setup {:sources [nl.builtins.formatting.fnlfmt]
                                                                :on_attach #(vim.keymap.set [:n
                                                                                             :v]
                                                                                            :<space>fm
                                                                                            vim.lsp.buf.format
                                                                                            {:buffer $2
                                                                                             :desc :format})}))
                                          :dependencies [:plenary.nvim]}
        :nvim-treesitter/nvim-treesitter {:config #(require :treesitter)}
        :nvim-treesitter/nvim-treesitter-context {:dependencies [:nvim-treesitter]
                                                  :enabled false}
        :lukas-reineke/indent-blankline.nvim {:event :VeryLazy
                                              :config #(let [ib (require :indent_blankline)]
                                                         (ib.setup {:filetype_exclude [:help
                                                                                       :terminal
                                                                                       :norg
                                                                                       :alpha]
                                                                    :buftype_exclude [:terminal]
                                                                    :show_trailing_blankline_indent false
                                                                    :show_first_indent_level false}))}
        :nvim-neorg/neorg {:ft :norg
                           :dependencies [:nvim-treesitter]
                           :config #(let [n (require :neorg)]
                                      (n.setup {:load {:core.defaults {}
                                                       :core.norg.concealer {}
                                                       :core.norg.manoeuvre {}
                                                       :core.norg.journal {:config {:workspace :journal}}
                                                       :core.norg.completion {:config {:engine :nvim-cmp}}
                                                       :core.norg.dirman {:config {:workspaces {:my_workspace "~/shared/neorg"
                                                                                                :journal "~/shared/journal"}}}}}))}
        :windwp/nvim-autopairs {:event :InsertEnter
                                :config #(let [ap (require :nvim-autopairs)
                                               cmp_autopairs (require :nvim-autopairs.completion.cmp)
                                               cmp (require :cmp)]
                                           (ap.setup {:disable_filetype [:TelescopePrompt
                                                                         :vim]
                                                      :enable_check_bracket_line false})
                                           (cmp.event:on :confirm_done
                                                         (cmp_autopairs.on_confirm_done {:map_char {:tex ""}})))
                                :dependencies [:nvim-cmp]}
        :kevinhwang91/nvim-bqf {:ft :qf
                                :config #(let [bqf (require :bqf)]
                                           (bqf.setup {:auto_resize_height false
                                                       :preview {:auto_preview false}}))}
        :nvim-telescope/telescope-fzf-native.nvim {:lazy true :build :make}
        :stevearc/dressing.nvim {:enabled false
                                 :event :VeryLazy
                                 :dependencies [:telescope.nvim]}
        :ThePrimeagen/harpoon {:event :VeryLazy
                               :dependencies [:plenary.nvim]
                               :config #(let [nmap (partial vim.keymap.set :n)]
                                          (nmap :<space>ha
                                                #(let [hm (require :harpoon.mark)]
                                                   (hm.add_file))
                                                {:desc "harpoon add file"})
                                          (nmap :<space>hl
                                                #(let [hu (require :harpoon.ui)]
                                                   (hu.toggle_quick_menu))
                                                {:desc "harpoon marks"})
                                          (nmap :<space>hn
                                                #(let [hu (require :harpoon.ui)]
                                                   (hu.nav_next))
                                                {:desc "harpoon next file"})
                                          (nmap :<space>hp
                                                #(let [hu (require :harpoon.ui)]
                                                   (hu.nav_prev))
                                                {:desc "harpoon prev file"}))}
        :nvim-telescope/telescope-ui-select.nvim {:lazy true}
        :nvim-telescope/telescope.nvim {:event :VeryLazy
                                        :config #(require :telescope-config)
                                        :dependencies [:telescope-fzf-native.nvim
                                                       :telescope-ui-select.nvim
                                                       :harpoon]}})

(local plugins (icollect [name config (pairs plists)]
                 (vim.tbl_extend :error config [name])))

(local lazy (require :lazy))
(lazy.setup plugins)
