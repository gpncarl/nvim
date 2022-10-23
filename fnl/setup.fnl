;; (require :impatient)
(require :pluginlist)
(require :options)

(fn _G.dump [...]
  (let [objects (vim.tbl_map vim.inspect [...])]
    (print (unpack objects))))

(fn switchHeader []
  (let [ alt_exts { :c   [ "h" ]
                  :cpp [ "h" "hpp" ]
                  :cc  [ "h" "hpp" ]
                  :hpp [ "cc" "cpp" ]
                  :h   [ "cc" "cpp" "c" ]
                  }
         ext (vim.fn.expand "%:e")
         basename (vim.fn.expand "%:t:r")
         alt_ext (. alt_exts ext)
         pattern_ext (vim.fn.join alt_ext "|")
         cmdstring (.. "fd -tf -1 --strip-cwd-prefix -s \"^" basename "\\.(" pattern_ext ")$\"|xargs printf %s")
         pathname (vim.fn.system cmdstring)]
    (if (= pathname "") (vim.fn.throw "pathname is empty")
        (= (vim.fn.bufexists pathname) 1) (vim.fn.execute (.. "buffer " pathname) "slient")
        (vim.fn.execute (.. "edit " pathname) "slient"))))

(vim.api.nvim_create_autocmd "FileType" {
    :pattern [ "text" ]
    :callback (fn []
                (set vim.opt.hlsearch true)
                (set vim.opt.number true))
})
(vim.api.nvim_create_autocmd "QuickFixCmdPre" { :command "packadd cfilter"})

(local nmap (partial vim.keymap.set :n))
(nmap :<space>d "<Cmd>!sdcv <cword><CR>" { :desc "sdcv dict" })
(nmap :<space>h switchHeader { :desc "switch header" })

(local tmap (partial vim.keymap.set :t))
(tmap :<c-w> "<c-\\><c-n><c-w>")

(set vim.g.netrw_list_hide "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+")
(set vim.g.netrw_winsize 20)
(set vim.g.netrw_altfile true)

(set vim.notify (require :notify))
