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
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
      { "saghen/blink.cmp" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspProgress", {
        group = require("utils").augroup("lsp_foldexpr"),
        callback = function(ev)
          local value = ev.data.params.value
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if value.kind == "end" and client and client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
          end
        end,
      })
      local servers = {
        "lua_ls",
        "clangd",
        "gopls",
        "rust_analyzer",
        "copilot",
      }
      for _, server in ipairs(servers) do
        local cfg = vim.lsp.config[server] or {}
        local cfg_root_dir = cfg.root_dir
        local cfg_root_markers = cfg.root_markers
        vim.lsp.config(server, {
          root_dir = function(bufnr, on_dir)
            local name = vim.api.nvim_buf_get_name(bufnr)
            if not require("utils").bufname_valid(name) then
              return
            end
            if type(cfg_root_dir) == "function" then
              cfg_root_dir(bufnr, on_dir)
            elseif type(cfg_root_dir) == "string" then
              on_dir(cfg_root_dir)
            elseif cfg_root_markers then
              on_dir(vim.fs.root(bufnr, cfg_root_markers))
            end
          end
        })
        vim.lsp.enable(server)
      end
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
}
