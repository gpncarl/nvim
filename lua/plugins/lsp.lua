return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    build = ":MasonUpdate",
    init = function()
      vim.env.PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin") .. ":" .. vim.env.PATH
    end,
    opts = {
      install_root_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason"),
      PATH = "skip",
    }
  },
  {
    "local/lspost",
    event = { "VeryLazy" },
    dev = true,
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "saghen/blink.cmp" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
          local value = ev.data.params.value
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if value.kind == "end" and client and client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
          end
        end,
      })
      vim.lsp.enable({
        "lua_ls",
        "clangd",
      })
    end
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
        vim.keymap.set("n", "<tab>", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local state = vim.b[bufnr].nes_state
            if state then
                -- Try to jump to the start of the suggestion edit.
                -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                    or (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                    )
                return nil
            else
                -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                return "<C-i>"
            end
        end, { desc = "Accept Copilot NES suggestion", expr = true })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "Bilal2453/luvit-meta" },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
}
