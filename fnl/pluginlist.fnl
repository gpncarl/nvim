(local plists {
    :rktjmp/hotpot.nvim {}
    ;; :lewis6991/impatient.nvim {}
    :wbthomason/packer.nvim {}
    :tpope/vim-vinegar {}
    :tpope/vim-surround {}
    :kyazdani42/nvim-web-devicons {}
    :navarasu/onedark.nvim {}
    :tpope/vim-unimpaired {}
    :tpope/vim-repeat {}
    :SmiteshP/nvim-gps {
        :module "nvim-gps"
        :config #(let [gps (require :nvim-gps)] (gps.setup))
    }

    :folke/which-key.nvim {
        :module "which-key"
        :config #(let [wk (require :which-key)]
                   (wk.setup { :plugins { :presets { :operators false :motions false :text_objects false } } }))
    }

    :phaazon/hop.nvim {
        :module "hop"
        :event "BufRead"
        :config #(let [h (require :hop)]
                  (h.setup { :keys "etovxqpdygfblzhckisuran" })
                  (require :hop_keymap))
    }

    :bkad/CamelCaseMotion {
        :event "BufRead"
        :setup #(set vim.g.camelcasemotion_key "<leader>")
    }

    :tpope/vim-fugitive {
        :event "BufRead"
        ;; config (partial set vim.opt.statusline "%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P")
    }

    :lewis6991/gitsigns.nvim {
        :event "BufRead"
        :module "gitsigns"
        :config #(let [gs (require :gitsigns)]
                   (gs.setup { :attach_to_untracked false }))
    }

    :wellle/targets.vim { :event "BufRead" }
    :antoinemadec/FixCursorHold.nvim {}
    :nvim-lua/plenary.nvim { :module "plenary" }
    :nvim-lua/popup.nvim { :module "popup" }
    :dstein64/vim-startuptime { :opt false }
    :RRethy/vim-illuminate { :opt false }
    :preservim/tagbar { :opt true }
    :godlygeek/tabular { :opt true }
    :mbbill/undotree { :opt true}
    :onsails/lspkind-nvim { :module "lspkind" }
    :hrsh7th/cmp-path { :after "nvim-cmp" }
    :hrsh7th/cmp-buffer { :after "nvim-cmp" }
    :hrsh7th/cmp-nvim-lsp { :after "nvim-cmp" }
    :saadparwaiz1/cmp_luasnip { :after "nvim-cmp"}

    :mfussenegger/nvim-dap {
        :opt true
        :config #(require :dapsetting)
    }

    :tzachar/cmp-tabnine {
        :run "./install.sh"
        :after "nvim-cmp"
    }

    :kyazdani42/nvim-tree.lua {
        :opt true
        :config #(let [tree (require :nvim-tree)] (tree.setup {}))
    }

    :stevearc/aerial.nvim { :opt true }

    :L3MON4D3/LuaSnip {
        :config #(let [loader (require :luasnip/loaders/from_vscode)
                       ls (require :luasnip)]
                   (loader.lazy_load)
                   (ls.setup { :history true :delete_check_events "TextChanged" }))
        :requires [ "rafamadriz/friendly-snippets" ]
    }

    :hrsh7th/nvim-cmp {
        :event "InsertEnter"
        :module "cmp"
        :config #(require :autocompletion)
    }

    :numToStr/Comment.nvim {
        :event "BufRead"
        :config #(let [c (require :Comment)] (c.setup {}))
    }

    :ludovicchabant/vim-gutentags {
        :event "BufRead"
        :setup #(and
                  (set vim.g.gutentags_modules [ "ctags" ])
                  (set vim.g.gutentags_ctags_exclude [ ".ccls-cache" ".cache" ".clangd" ".vscode" ]))
    }

    :ellisonleao/gruvbox.nvim {
        :opt false
        :as "theme"
        :config #(let [gruvbox (require :gruvbox)]
                   (gruvbox.setup
                     { :undercurl true
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
                   (vim.cmd "colorscheme gruvbox"))
    }

    :hoob3rt/lualine.nvim { :config #(require :statusline) }

    :goolord/alpha-nvim {
        :cond #(= (vim.fn.argc) 0)
        :wants [ "theme" ]
        :config #(let [alpha (require :alpha)
                       startify (require :alpha.themes.startify)]
                    (set startify.nvim_web_devicons.enabled true)
                    (alpha.setup startify.config))
    }

    :folke/trouble.nvim {
        :event "DiagnosticChanged"
        :config #(let [t (require :trouble)]
                   (t.setup { :icons true })
                   (vim.keymap.set "n" "<leader>t" "<Cmd>TroubleToggle<CR>" { desc "toggle troube" }))
    }

    :neovim/nvim-lspconfig { :config #(require :lspsetting) }

    :nvim-treesitter/nvim-treesitter { :config #(require :treesitter) }

    :nvim-treesitter/nvim-treesitter-context {
        :wants [ "nvim-treesitter" ]
        :disable true
    }

    :lukas-reineke/indent-blankline.nvim {
        :config #(let [ib (require :indent_blankline)]
                   (ib.setup
                     { :filetype_exclude [ "help"  "terminal" "norg" "alpha" ]
                     :buftype_exclude [ "terminal" ]
                     :show_trailing_blankline_indent false
                     :show_first_indent_level false
                     }))
    }

    :nvim-neorg/neorg {
        :ft "norg"
        :wants [ "nvim-treesitter" ]
        :config #(let [n (require :neorg)]
                   (n.setup { :load {
                        :core.defaults {}
                        :core.norg.concealer {}
                        :core.gtd.base { :config { :workspace "gtd" } }
                        :core.norg.manoeuvre {}
                        :core.norg.journal { :config { :workspace "journal" }}
                        :core.norg.completion { :config { :engine "nvim-cmp" } }
                        :core.norg.dirman { :config { :workspaces {
                            :my_workspace "~/shared/neorg"
                            :gtd "~/shared/gtd"
                            :journal "~/shared/journal"
                        }}}}}))
    }

    :windwp/nvim-autopairs {
        :event "InsertEnter"
        :config #(let [ap (require :nvim-autopairs)
                       cmp_autopairs (require :nvim-autopairs.completion.cmp)
                       cmp (require :cmp)]
                    (ap.setup { :disable_filetype [ "TelescopePrompt" "vim" ]
                                :enable_check_bracket_line false })
                    (cmp.event:on "confirm_done"
                                  (cmp_autopairs.on_confirm_done { :map_char { :tex "" } })))
    }

    :kevinhwang91/nvim-bqf {
        :ft "qf"
        :config #(let [bqf (require :bqf)]
                   (bqf.setup { :auto_resize_height false
                              :preview { :auto_preview false }}))
    }

    :nvim-telescope/telescope.nvim {
        :event "BufRead"
        :module "telescope"
        :config #(require :telescope-config)
        :wants [ "telescope-fzf-native.nvim" ]
        :requires [ { 1 "nvim-telescope/telescope-fzf-native.nvim" :run "make" :module "fzf_lib" } ]
    }
})

(local packer (require :packer))
(local use packer.use)
(local util (require :packer.util))
(local layout { :display { :open_fn util.float :border [ "┌" "─" "┐" "│" "┘" "─" "└" "│" ]}})
(local plugins (icollect [name config (pairs plists)] (vim.tbl_extend "error" config [name])))
(packer.startup #(use plugins) layout)
