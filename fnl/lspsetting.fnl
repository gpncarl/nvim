(local signs { :Error " " :Warn " " :Hint " " :Info " " })
(local colors { :Error "Red" :Warn "Orange" :Hint "LightGrey" :Info "LightBlue" })

(each [type icon (pairs signs)]
  (let [hl (.. "DiagnosticSign" type)]
    (vim.cmd (.. "hi " hl " guifg=" (. colors type) " guibg=#ebdbb2"))
    (vim.fn.sign_define hl { :text icon :texthl hl :numhl "" })))

(local lspconfig (require :lspconfig))

(local fuzzy (require :telescope.builtin))
(local nmap (partial vim.keymap.set :n))
(fn on_attach [ client bufnr ]
    ;; require'aerial'.on_attach(client)
    (nmap :gd fuzzy.lsp_definitions { :buffer bufnr :desc "goto define" })
    (nmap :gr fuzzy.lsp_references { :buffer bufnr :desc "goto reference" })
    (nmap :<space>a vim.lsp.buf.code_action { :buffer bufnr :desc "code action" })
    (nmap :<space>w fuzzy.lsp_dynamic_workspace_symbols { :buffer bufnr :desc "dynamic workspace symbols" })
    (nmap :gw fuzzy.lsp_workspace_symbols { :buffer bufnr :desc "workspace symbols"})
    (nmap :gs fuzzy.lsp_document_symbols { :buffer bufnr :desc "document symbols" })

    (when (= client.name "clangd")
        (nmap :<space>h "<cmd>ClangdSwitchSourceHeader<cr>" { :buffer bufnr :desc "switch header" })))

(nmap :K vim.diagnostic.open_float { :desc "current line diagnostic" })
(nmap "[g" (partial vim.diagnostic.goto_prev { :float false }) { :desc "goto previous diagnostic" })
(nmap "]g" (partial vim.diagnostic.goto_next { :float false }) { :desc "goto next diagnostic" })


(local capabilities (vim.lsp.protocol.make_client_capabilities))
;; NOTE: expand "require('cmp_nvim_lsp').update_capabilities(capabilities)" here, for snippets support
(set capabilities.textDocument.completion.completionItem {
    :snippetSupport true
    :preselectSupport true
    :insertReplaceSupport true
    :labelDetailsSupport true
    :deprecatedSupport true
    :commitCharactersSupport true
    :tagSupport { :valueSet [ 1 ] }
    :resolveSupport {
        :properties [ "documentation"
                     "detail"
                     "additionalTextEdits" ]
    }
})

(tset vim.lsp.handlers "textDocument/publishDiagnostics"
      (vim.lsp.with
        vim.lsp.diagnostic.on_publish_diagnostics
        { :underline true
        :virtual_text true
        :signs true
        :update_in_insert false }))

(lspconfig.hls.setup { :autostart false :on_attach on_attach })
(lspconfig.pylsp.setup { :autostart false :on_attach on_attach :capabilities capabilities })
(lspconfig.clangd.setup { :autostart false :on_attach on_attach :capabilities capabilities })
