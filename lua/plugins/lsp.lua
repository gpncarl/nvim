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
      vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })
      local servers = {
        "lua_ls",
        "clangd",
        "gopls",
        "rust_analyzer",
      }
      for _, server in ipairs(servers) do
        local cfg = vim.lsp.config[server] or {}
        local cfg_root_dir = cfg.root_dir
        local cfg_root_markers = cfg.root_markers
        vim.lsp.config(server, {
          root_dir = require("utils").root_dir_wrapper(cfg_root_dir, cfg_root_markers)
        })
        vim.lsp.enable(server)
      end
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      integrations = {
        lspconfig = false,
      }
    },
    config = function(_, opts)
      require("lazydev").setup(opts)
      for _, server in ipairs(require("lazydev.lsp").supported_clients) do
        if vim.lsp.is_enabled(server) then
          vim.lsp.config(server, {
            root_dir = require("utils").root_dir_wrapper(function(bufnr, on_dir)
              on_dir(require("lazydev").find_workspace(bufnr))
            end),
          })
        end
      end
    end
  },
}
