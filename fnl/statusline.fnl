;; (local gps (require :nvim-gps))
(local lualine (require :lualine))

(lualine.setup {:options {:icons_enabled true
                          :theme :auto
                          :component_separators {:left "" :right ""}
                          :section_separators {:left "" :right ""}
                          :disabled_filetypes {:statusline {} :winbar {}}
                          :ignore_focus {}
                          :always_divide_middle true
                          :globalstatus false
                          :refresh {:statusline 1000
                                    :tabline 1000
                                    :winbar 1000}}
                :sections {:lualine_a [:mode]
                           :lualine_b [:branch :diff :diagnostics]
                           :lualine_c [:filename]
                           :lualine_x [:encoding :fileformat :filetype]
                           :lualine_y [:progress]
                           :lualine_z [:location]}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [:filename]
                                    :lualine_x [:location]
                                    :lualine_y []
                                    :lualine_z []}
                ;; :tabline {
                ;;     :lualine_a [ { 1 "buffers" :mode 4 } ]
                ;;     :lualine_z [ "tabs" ]
                ;; }
                ;; :winbar {
                ;;      :lualine_c [ "filetype" { 1 gps.get_location :cond gps.is_available } ]
                ;; }
                ;; :inactive_winbar {}
                :extensions [:quickfix :fugitive]})
