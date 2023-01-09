(local hop (require :hop))
(local hint (require :hop.hint))
;; (local wk (require :which-key))
;; (wk.register { :leader "extend motion" })

(local map (partial vim.keymap.set ""))

(map :<leader><leader>F
     (partial hop.hint_char1 {:direction hint.HintDirection.AFTER_CURSOR})
     {:desc "search one char before cursor"})

(map :<leader><leader>f
     (partial hop.hint_char1 {:direction hint.HintDirection.AFTER_CURSOR})
     {:desc "search one char after cursor"})

(map :<leader><leader>S
     (partial hop.hint_char2 {:direction hint.HintDirection.BEFORE_CURSOR})
     {:desc "search two char before cursor"})

(map :<leader><leader>s
     (partial hop.hint_char2 {:direction hint.HintDirection.AFTER_CURSOR})
     {:desc "search two char after cursor"})

(map :<leader><leader>w
     (partial hop.hint_words
              {:direction hint.HintDirection.AFTER_CURSOR
               :hint_position hint.HintPosition.BEGIN})
     {:desc "word begin after cursor"})

(map :<leader><leader>b
     (partial hop.hint_words
              {:direction hint.HintDirection.BEFORE_CURSOR
               :hint_position hint.HintPosition.BEGIN})
     {:desc "word begin before cursor"})

(map :<leader><leader>e
     (partial hop.hint_words
              {:direction hint.HintDirection.AFTER_CURSOR
               :hint_position hint.HintPosition.END})
     {:desc "word end after cursor"})

(map :<leader><leader>ge
     (partial hop.hint_words
              {:direction hint.HintDirection.BEFORE_CURSOR
               :hint_position hint.HintPosition.END})
     {:desc "word end before cursor"})

(map :<leader><leader>q hop.hint_patterns {:desc :query})

(map :<leader><leader>j
     (partial hop.hint_lines {:direction hint.HintDirection.AFTER_CURSOR})
     {:desc "line start after cursor"})

(map :<leader><leader>k
     (partial hop.hint_lines {:direction hint.HintDirection.BEFORE_CURSOR})
     {:desc "line start before cursor"})

(map :<leader><leader>J
     (partial hop.hint_lines_skip_whitespace
              {:direction hint.HintDirection.AFTER_CURSOR})
     {:desc "line head after cursor"})

(map :<leader><leader>K
     (partial hop.hint_lines_skip_whitespace
              {:direction hint.HintDirection.BEFORE_CURSOR})
     {:desc "line head before cursor"})
