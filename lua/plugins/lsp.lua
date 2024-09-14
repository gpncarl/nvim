local on_attach = function(client, bufnr)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "goto define" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "goto declaration" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "goto implementation" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "code hover" })
  vim.keymap.set('n', "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "code signature" })

  vim.keymap.set("n", "grd", function() require("telescope.builtin").lsp_definitions() end,
    { buffer = bufnr, desc = "goto define" })
  vim.keymap.set("n", "grr", function() require("telescope.builtin").lsp_references() end,
    { buffer = bufnr, desc = "goto references" })
  vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "goto declaration" })
  vim.keymap.set("n", "gri", function() require("telescope.builtin").lsp_implementations() end,
    { buffer = bufnr, desc = "goto implementation" })
  vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format, { buffer = bufnr, desc = "format" })
  vim.keymap.set("n", "grk", vim.lsp.buf.hover, { buffer = bufnr, desc = "code hover" })
  vim.keymap.set('n', "grK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "code signature" })

  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  if client.supports_method("textDocument/codeLens") then
    local refresh = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end
    refresh()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = refresh,
    })
  end
end

local get_default_opts = function()
  return {
    inlay_hints = { enabled = true, },
    codelens = { enabled = true, },
    document_highlight = { enabled = true, },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
  }
end

local default_lsp_handler = function(server_name)
  require("lspconfig")[server_name].setup(get_default_opts())
end

local get_lsp_handler = function()
  local default_opts = get_default_opts()
  local lspconfig = require("lspconfig")
  return {
    clangd = function()
      lspconfig.clangd.setup(vim.tbl_extend("force", default_opts, {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require("clangd_extensions").setup()
          vim.keymap.set("n", "grh", "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "switch header" })
          vim.keymap.set("n", "<leader>sh", "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "switch header" })
        end,
        cmd = { "clangd", "--offset-encoding=utf-16" },
      }))
    end,
    lua_ls = function()
      lspconfig.lua_ls.setup(vim.tbl_extend("force", default_opts, {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            codeLens = { enable = true, }
          }
        }
      }))
    end
  }
end

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
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    build = ":MasonUpdate",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          { "p00f/clangd_extensions.nvim" },
          { "folke/neoconf.nvim",         opts = {} },
        },
      },
    },
    config = function()
      local manual_installed = { "clangd" }
      local ensure_installed = { "lua_ls" }
      local handlers = get_lsp_handler()
      for _, server_name in ipairs(manual_installed) do
        ensure_installed[server_name] = nil
        if handlers[server_name] ~= nil then
          handlers[server_name]()
        else
          default_lsp_handler(server_name)
        end
      end

      handlers[1] = default_lsp_handler
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = handlers,
      })
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvimtools/none-ls.nvim", opts = {} },
    },
    opts = function()
      local null_ls = require("null-ls")
      return {
        ensure_installed = {},
        handlers = {
          nil, -- use default handler
        },
      }
    end
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {}
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
