(local plists
       {:rktjmp/hotpot.nvim {:enable true}
        :stevearc/oil.nvim {:config #(let [oil (require :oil)]
                                       (oil.setup {})
                                       (vim.keymap.set :n "-" oil.open
                                                       {:desc "Open parent directory"}))}
        :kylechui/nvim-surround {:keys [{1 :ds :mode :n}
                                        {1 :ys :mode :n}
                                        {1 :cs :mode :n}
                                        {1 :S :mode :v}
                                        {1 :<C-g>s :mode :i}
                                        {1 :<C-g>S :mode :i}]
                                 :config true}
        :nvim-tree/nvim-web-devicons {:lazy true}
        :navarasu/onedark.nvim {:lazy true :priority 1000}
        :tpope/vim-unimpaired {:keys ["[" "]"]}
        :tpope/vim-repeat {:keys "."}
        :tpope/vim-rsi {:event [:InsertEnter :CmdlineEnter]}
        :tpope/vim-sleuth {:lazy true}
        :tpope/vim-abolish {:event :CmdlineEnter}
        :akinsho/toggleterm.nvim {:keys "<c-\\><c-\\>"
                                  :opts {:open_mapping "<c-\\><c-\\>"}}
        :SmiteshP/nvim-gps {:lazy true :opts {}}
        :folke/which-key.nvim {:keys ["`" "'" "\"" :<space> :<leader>]
                               :opts {:plugins {:presets {:operators false
                                                          :motions false
                                                          :text_objects false}}}}
        :phaazon/hop.nvim {:keys :<leader><leader>
                           :config #(let [h (require :hop)]
                                      (h.setup {:keys :etovxqpdygfblzhckisuran})
                                      (require :hop_keymap))}
        :ggandor/leap.nvim {:lazy true
                            :dependencies [:vim-repeat :leap-spooky]
                            :config #(let [l (require :leap)]
                                       (l.add_default_mappings))}
        :ggandor/leap-spooky.nvim {:lazy true :config true}
        :ggandor/flit.nvim {:lazy true :config true}
        :bkad/CamelCaseMotion {:event "ModeChanged *:no"
                               :keys [:<leader>w
                                      :<leader>b
                                      :<leader>e
                                      :<leader>ge]
                               :init #(set vim.g.camelcasemotion_key :<leader>)}
        :tpope/vim-fugitive {:event :CmdlineEnter}
        :lewis6991/gitsigns.nvim {:event :VeryLazy
                                  :opts {:attach_to_untracked false
                                         :trouble false}}
        :wellle/targets.vim {:event "ModeChanged *:no"}
        :antoinemadec/FixCursorHold.nvim {:event :VeryLazy}
        :nvim-lua/plenary.nvim {:lazy true}
        :nvim-lua/popup.nvim {:lazy true}
        :RRethy/vim-illuminate {:lazy true}
        :preservim/tagbar {:lazy true}
        :godlygeek/tabular {:lazy true}
        :mbbill/undotree {:lazy true}
        :onsails/lspkind-nvim {:lazy true}
        :hrsh7th/cmp-path {:lazy true}
        :hrsh7th/cmp-buffer {:lazy true}
        :hrsh7th/cmp-nvim-lsp {:lazy true}
        :saadparwaiz1/cmp_luasnip {:lazy true :dependencies [:LuaSnip]}
        :MunifTanjim/nui.nvim {:lazy true}
        :rcarriga/nvim-notify {:lazy true :opts {:top_down false}}
        :folke/noice.nvim {:lazy true
                           :dependencies [:nvim-notify
                                          :nui.nvim
                                          :nvim-treesitter]
                           :config true}
        :j-hui/fidget.nvim {:event :LspAttach :config true}
        :mfussenegger/nvim-dap {:lazy true :config #(require :dapsetting)}
        :tzachar/cmp-tabnine {:build :./install.sh :lazy true}
        :nvim-neo-tree/neo-tree.nvim {:keys [{1 :<space>ft
                                              2 "<cmd>Neotree toggle<cr>"
                                              :mode :n
                                              :desc "Neotree toggle"}
                                             {1 :<space>fb
                                              2 "<cmd>Neotree buffers toggle<cr>"
                                              :mode :n
                                              :desc "Neotree buffers toggle"}]
                                      :opts {:buffers {:follow_current_file true
                                                       :group_empty_dirs true
                                                       :show_unloaded true}
                                             :filesystem {:hijack_netrw_behavior :disabled}}}
        :stevearc/aerial.nvim {:lazy true}
        :rafamadriz/friendly-snippets {:lazy true}
        :L3MON4D3/LuaSnip {:lazy true
                           :dependencies [:friendly-snippets]
                           :config #(let [loader (require :luasnip/loaders/from_vscode)
                                          ls (require :luasnip)]
                                      (loader.lazy_load)
                                      (ls.setup {:history true
                                                 :delete_check_events :TextChanged}))}
        :hrsh7th/nvim-cmp {:event :InsertEnter
                           :dependencies [:lspkind-nvim
                                          :cmp-path
                                          :cmp-buffer
                                          :cmp-tabnine
                                          :cmp_luasnip
                                          :cmp-nvim-lsp]
                           :config #(require :autocompletion)}
        :numToStr/Comment.nvim {:keys [{1 :gc :mode [:n :v :o]}] :config true}
        :ludovicchabant/vim-gutentags {:event :VeryLazy
                                       :init #(and (set vim.g.gutentags_modules
                                                        [:ctags])
                                                   (set vim.g.gutentags_ctags_exclude
                                                        [:.ccls-cache
                                                         :.cache
                                                         :.clangd
                                                         :.vscode]))}
        :ellisonleao/gruvbox.nvim {:lazy true
                                   :priority 1000
                                   :opts {:undercurl true
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
                                          :overrides {}}}
        :hoob3rt/lualine.nvim {:config #(require :statusline)}
        :goolord/alpha-nvim {:cond #(= (vim.fn.argc) 0)
                             :dependencies [:nvim-web-devicons]
                             :config #(let [alpha (require :alpha)
                                            startify (require :alpha.themes.startify)]
                                        (set startify.nvim_web_devicons.enabled
                                             true)
                                        (alpha.setup startify.config))}
        :folke/trouble.nvim {:keys [:<leader>t]
                             :config #(let [t (require :trouble)]
                                        (t.setup {:icons true})
                                        (vim.keymap.set :n :<leader>t
                                                        :<Cmd>TroubleToggle<CR>
                                                        {:desc "toggle troube"}))}
        :neovim/nvim-lspconfig {:config #(require :lspsetting)}
        :jose-elias-alvarez/null-ls.nvim {:event :VeryLazy
                                          :dependencies [:plenary.nvim]
                                          :config #(let [nl (require :null-ls)]
                                                     (nl.setup {:sources [nl.builtins.formatting.fnlfmt]
                                                                :on_attach #(vim.keymap.set [:n
                                                                                             :v]
                                                                                            :<space>fm
                                                                                            vim.lsp.buf.format
                                                                                            {:buffer $2
                                                                                             :desc :format})}))}
        :nvim-treesitter/nvim-treesitter {:config #(require :treesitter)}
        :nvim-treesitter/nvim-treesitter-textobjects {:event "ModeChanged *:no"
                                                      :keys ["[" "]"]
                                                      :dependencies [:nvim-treesitter]}
        :nvim-treesitter/nvim-treesitter-context {:lazy true
                                                  :dependencies [:nvim-treesitter]}
        :lukas-reineke/indent-blankline.nvim {:event :VeryLazy
                                              :opts {:filetype_exclude [:help
                                                                        :terminal
                                                                        :norg
                                                                        :alpha]
                                                     :buftype_exclude [:terminal]
                                                     :show_trailing_blankline_indent false
                                                     :show_first_indent_level false}}
        :nvim-neorg/neorg {:ft :norg
                           :dependencies [:nvim-treesitter :nvim-cmp]
                           :opts {:load {:core.defaults {}
                                         :core.norg.concealer {}
                                         :core.norg.manoeuvre {}
                                         :core.norg.journal {:config {:workspace :journal}}
                                         :core.norg.completion {:config {:engine :nvim-cmp}}
                                         :core.norg.dirman {:config {:workspaces {:my_workspace "~/shared/neorg"
                                                                                  :journal "~/shared/journal"}}}}}}
        :windwp/nvim-autopairs {:event :InsertEnter
                                :dependencies [:nvim-cmp]
                                :config #(let [ap (require :nvim-autopairs)
                                               cmp_autopairs (require :nvim-autopairs.completion.cmp)
                                               cmp (require :cmp)]
                                           (ap.setup {:disable_filetype [:TelescopePrompt
                                                                         :vim]
                                                      :enable_check_bracket_line false})
                                           (cmp.event:on :confirm_done
                                                         (cmp_autopairs.on_confirm_done {:map_char {:tex ""}})))}
        :kevinhwang91/nvim-bqf {:ft :qf
                                :opts {:auto_resize_height false
                                       :preview {:auto_preview false}}}
        :nvim-telescope/telescope-fzf-native.nvim {:lazy true :build :make}
        :stevearc/dressing.nvim {:lazy true :dependencies [:telescope.nvim]}
        :ThePrimeagen/harpoon {:keys :<space>
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
        :nvim-telescope/telescope.nvim {:keys :<space>
                                        :dependencies [:telescope-fzf-native.nvim
                                                       :telescope-ui-select.nvim
                                                       :harpoon]
                                        :config #(require :telescope-config)}})

(local plugins (icollect [name config (pairs plists)]
                 (vim.tbl_extend :error config [name])))

(local lazy (require :lazy))
(lazy.setup plugins)
