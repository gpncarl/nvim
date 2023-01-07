(local telescope (require :telescope))
(local actions (require :telescope.actions.layout))

(telescope.setup {
    :extensions {
        :fzf {
          :fuzzy true
          :override_generic_sorter true
          :override_file_sorter true
          :case_mode "smart_case"
        }
    }
    :defaults {
        :mappings {
            :i {
                "<C-_>" actions.toggle_preview
            }
        }
        :sorting_strategy "ascending"
        :layout_strategy "horizontal"
        :layout_config {
            :prompt_position "top"
            :preview_width 0.6
            :height 0.5
            :width 0.8
        }
        :border true
        :preview {
            :hide_on_startup true
        }
    }
})

(telescope.load_extension "fzf")
(telescope.load_extension "ui-select")
(telescope.load_extension "harpoon")

(local fuzzy
       (fn [name opts]
         (let [ default_opts { :push_cursor_on_edit true :winblend 10 }
                builtin (require :telescope.builtin)
                result (vim.tbl_extend "keep"  (or opts {}) default_opts) ]
           (partial (. builtin name) result))))


(local nmap (partial vim.keymap.set :n))
(nmap :<space>o (partial (fuzzy "treesitter") { :buffer 0 }) { :desc "fuzzy outline" })
(nmap :<space>ff (fuzzy "find_files") { :desc "fuzzy files" })
(nmap :<space>gf (fuzzy "git_files" { :show_untracked false }) { :desc "fuzzy git files" })
(nmap :<space>m (fuzzy "oldfiles") { :desc "fuzzy oldfiles" })
(nmap :<space>b (fuzzy "buffers") { :desc "fuzzy buffers" })
(nmap :<leader>r (fuzzy "grep_string") { :desc "fuzzy string" })
(nmap :<space>r (fuzzy "live_grep") { :desc "live fuzzy string" })
(nmap :<space>j (fuzzy "jumplist") { :desc "fuzzy jumplist" })
(nmap :<space>q (fuzzy "quickfix") { :desc "fuzzy quickfix" })
(nmap :<space>l (fuzzy "loclist") { :desc "fuzzy loclist" })
(nmap :<space>ht #(telescope.extensions.harpoon.marks) { :desc "fuzzy harpoon marks" })
