local plists
local function _1_()
  local oil = require("oil")
  oil.setup({})
  return vim.keymap.set("n", "-", oil.open, {desc = "Open parent directory"})
end
local function _2_()
  local h = require("hop")
  h.setup({keys = "etovxqpdygfblzhckisuran"})
  return require("hop_keymap")
end
local function _3_()
  local l = require("leap")
  return l.add_default_mappings()
end
local function _4_()
  vim.g.camelcasemotion_key = "<leader>"
  return nil
end
local function _5_()
  return require("dapsetting")
end
local function _6_()
  local loader = require("luasnip/loaders/from_vscode")
  local ls = require("luasnip")
  loader.lazy_load()
  return ls.setup({history = true, delete_check_events = "TextChanged"})
end
local function _7_()
  return require("autocompletion")
end
local function _8_()
  local function _9_()
    vim.g.gutentags_modules = {"ctags"}
    return nil
  end
  local function _10_()
    vim.g.gutentags_ctags_exclude = {".ccls-cache", ".cache", ".clangd", ".vscode"}
    return nil
  end
  return (_9_() and _10_())
end
local function _11_()
  return require("statusline")
end
local function _12_()
  return (vim.fn.argc() == 0)
end
local function _13_()
  local alpha = require("alpha")
  local startify = require("alpha.themes.startify")
  startify.nvim_web_devicons.enabled = true
  return alpha.setup(startify.config)
end
local function _14_()
  local t = require("trouble")
  t.setup({icons = true})
  return vim.keymap.set("n", "<leader>t", "<Cmd>TroubleToggle<CR>", {desc = "toggle troube"})
end
local function _15_()
  return require("lspsetting")
end
local function _16_()
  local m = require("mason")
  return m.setup({})
end
local function _17_()
  local m = require("mason-lspconfig")
  return m.setup({})
end
local function _18_()
  local m = require("mason-null-ls")
  return m.setup({})
end
local function _19_()
  local nl = require("null-ls")
  local function _20_(_2410, _2420)
    return vim.keymap.set({"n", "v"}, "<space>fm", vim.lsp.buf.format, {buffer = _2420, desc = "format"})
  end
  return nl.setup({sources = {nl.builtins.formatting.fnlfmt}, on_attach = _20_})
end
local function _21_()
  return require("treesitter")
end
local function _22_()
  local ap = require("nvim-autopairs")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  ap.setup({disable_filetype = {"TelescopePrompt", "vim"}, enable_check_bracket_line = false})
  return (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
end
local function _23_()
  local nmap
  local function _24_(...)
    return vim.keymap.set("n", ...)
  end
  nmap = _24_
  local function _25_()
    local hm = require("harpoon.mark")
    return hm.add_file()
  end
  nmap("<space>ha", _25_, {desc = "harpoon add file"})
  local function _26_()
    local hu = require("harpoon.ui")
    return hu.toggle_quick_menu()
  end
  nmap("<space>hl", _26_, {desc = "harpoon marks"})
  local function _27_()
    local hu = require("harpoon.ui")
    return hu.nav_next()
  end
  nmap("<space>hn", _27_, {desc = "harpoon next file"})
  local function _28_()
    local hu = require("harpoon.ui")
    return hu.nav_prev()
  end
  return nmap("<space>hp", _28_, {desc = "harpoon prev file"})
end
local function _29_()
  return require("telescope-config")
end
plists = {["rktjmp/hotpot.nvim"] = {enabled = true}, ["stevearc/oil.nvim"] = {config = _1_}, ["kylechui/nvim-surround"] = {keys = {{"ds", mode = "n"}, {"ys", mode = "n"}, {"cs", mode = "n"}, {"S", mode = "v"}, {"<C-g>s", mode = "i"}, {"<C-g>S", mode = "i"}}, config = true}, ["nvim-tree/nvim-web-devicons"] = {lazy = true}, ["navarasu/onedark.nvim"] = {lazy = true, priority = 1000}, ["tpope/vim-unimpaired"] = {keys = {"[", "]"}}, ["tpope/vim-repeat"] = {keys = "."}, ["tpope/vim-rsi"] = {event = {"InsertEnter", "CmdlineEnter"}}, ["tpope/vim-sleuth"] = {lazy = true}, ["tpope/vim-abolish"] = {event = "CmdlineEnter"}, ["akinsho/toggleterm.nvim"] = {keys = "<c-\\><c-\\>", opts = {open_mapping = "<c-\\><c-\\>"}}, ["SmiteshP/nvim-gps"] = {lazy = true, opts = {}}, ["folke/which-key.nvim"] = {keys = {"`", "'", "\"", "<space>", "<leader>"}, opts = {plugins = {presets = {motions = false, text_objects = false, operators = false}}}}, ["phaazon/hop.nvim"] = {keys = "<leader><leader>", config = _2_}, ["ggandor/leap.nvim"] = {lazy = true, dependencies = {"vim-repeat", "leap-spooky"}, config = _3_}, ["ggandor/leap-spooky.nvim"] = {lazy = true, config = true}, ["ggandor/flit.nvim"] = {lazy = true, config = true}, ["bkad/CamelCaseMotion"] = {event = "ModeChanged *:no", keys = {"<leader>w", "<leader>b", "<leader>e", "<leader>ge"}, init = _4_}, ["tpope/vim-fugitive"] = {event = "CmdlineEnter"}, ["lewis6991/gitsigns.nvim"] = {event = "VeryLazy", opts = {trouble = false, attach_to_untracked = false}}, ["wellle/targets.vim"] = {event = "ModeChanged *:no"}, ["antoinemadec/FixCursorHold.nvim"] = {event = "VeryLazy"}, ["nvim-lua/plenary.nvim"] = {lazy = true}, ["nvim-lua/popup.nvim"] = {lazy = true}, ["RRethy/vim-illuminate"] = {lazy = true}, ["preservim/tagbar"] = {lazy = true}, ["godlygeek/tabular"] = {lazy = true}, ["mbbill/undotree"] = {lazy = true}, ["onsails/lspkind-nvim"] = {lazy = true}, ["hrsh7th/cmp-path"] = {lazy = true}, ["hrsh7th/cmp-buffer"] = {lazy = true}, ["hrsh7th/cmp-nvim-lsp"] = {lazy = true}, ["saadparwaiz1/cmp_luasnip"] = {lazy = true, dependencies = {"LuaSnip"}}, ["MunifTanjim/nui.nvim"] = {lazy = true}, ["rcarriga/nvim-notify"] = {lazy = true, opts = {top_down = false}}, ["folke/noice.nvim"] = {lazy = true, dependencies = {"nvim-notify", "nui.nvim", "nvim-treesitter"}, config = true}, ["j-hui/fidget.nvim"] = {event = "LspAttach", config = true}, ["mfussenegger/nvim-dap"] = {lazy = true, config = _5_}, ["tzachar/cmp-tabnine"] = {build = "./install.sh", lazy = true}, ["nvim-neo-tree/neo-tree.nvim"] = {keys = {{"<space>ft", "<cmd>Neotree toggle<cr>", mode = "n", desc = "Neotree toggle"}, {"<space>fb", "<cmd>Neotree buffers toggle<cr>", mode = "n", desc = "Neotree buffers toggle"}}, opts = {buffers = {follow_current_file = true, group_empty_dirs = true, show_unloaded = true}, filesystem = {hijack_netrw_behavior = "disabled"}}}, ["stevearc/aerial.nvim"] = {lazy = true}, ["rafamadriz/friendly-snippets"] = {lazy = true}, ["L3MON4D3/LuaSnip"] = {lazy = true, dependencies = {"friendly-snippets"}, config = _6_}, ["hrsh7th/nvim-cmp"] = {event = "InsertEnter", dependencies = {"lspkind-nvim", "cmp-path", "cmp-buffer", "cmp-tabnine", "cmp_luasnip", "cmp-nvim-lsp"}, config = _7_}, ["numToStr/Comment.nvim"] = {keys = {{"gc", mode = {"n", "v", "o"}}}, config = true}, ["ludovicchabant/vim-gutentags"] = {event = "VeryLazy", init = _8_}, ["ellisonleao/gruvbox.nvim"] = {lazy = true, priority = 1000, opts = {undercurl = true, underline = true, bold = true, strikethrough = true, inverse = true, contrast = "", overrides = {}, italic = false, invert_selection = false, invert_signs = false, invert_tabline = false, invert_intend_guides = false}}, ["hoob3rt/lualine.nvim"] = {config = _11_}, ["goolord/alpha-nvim"] = {cond = _12_, dependencies = {"nvim-web-devicons"}, config = _13_}, ["folke/trouble.nvim"] = {keys = {"<leader>t"}, config = _14_}, ["neovim/nvim-lspconfig"] = {config = _15_, lazy = false}, ["williamboman/mason.nvim"] = {config = _16_}, ["williamboman/mason-lspconfig.nvim"] = {dependencies = {"mason.nvim", "nvim-lspconfig"}, config = _17_}, ["jay-babu/mason-null-ls.nvim"] = {dependencies = {"mason.nvim", "null-ls.nvim"}, config = _18_}, ["jose-elias-alvarez/null-ls.nvim"] = {event = "VeryLazy", dependencies = {"plenary.nvim"}, config = _19_}, ["nvim-treesitter/nvim-treesitter"] = {config = _21_}, ["nvim-treesitter/nvim-treesitter-textobjects"] = {event = "ModeChanged *:no", keys = {"[", "]"}, dependencies = {"nvim-treesitter"}}, ["nvim-treesitter/nvim-treesitter-context"] = {lazy = true, dependencies = {"nvim-treesitter"}}, ["lukas-reineke/indent-blankline.nvim"] = {event = "VeryLazy", opts = {filetype_exclude = {"help", "terminal", "norg", "alpha"}, buftype_exclude = {"terminal"}, show_trailing_blankline_indent = false, show_first_indent_level = false}}, ["nvim-neorg/neorg"] = {ft = "norg", dependencies = {"nvim-treesitter", "nvim-cmp"}, opts = {load = {["core.defaults"] = {}, ["core.norg.concealer"] = {}, ["core.norg.manoeuvre"] = {}, ["core.norg.journal"] = {config = {workspace = "journal"}}, ["core.norg.completion"] = {config = {engine = "nvim-cmp"}}, ["core.norg.dirman"] = {config = {workspaces = {my_workspace = "~/shared/neorg", journal = "~/shared/journal"}}}}}}, ["windwp/nvim-autopairs"] = {event = "InsertEnter", dependencies = {"nvim-cmp"}, config = _22_}, ["kevinhwang91/nvim-bqf"] = {ft = "qf", opts = {preview = {auto_preview = false}, auto_resize_height = false}}, ["nvim-telescope/telescope-fzf-native.nvim"] = {lazy = true, build = "make"}, ["stevearc/dressing.nvim"] = {lazy = true, dependencies = {"telescope.nvim"}}, ["ThePrimeagen/harpoon"] = {keys = "<space>", dependencies = {"plenary.nvim"}, config = _23_}, ["nvim-telescope/telescope-ui-select.nvim"] = {lazy = true}, ["nvim-telescope/telescope.nvim"] = {keys = "<space>", dependencies = {"telescope-fzf-native.nvim", "telescope-ui-select.nvim", "harpoon"}, config = _29_}}
local plugins
do
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for name, config in pairs(plists) do
    local val_19_auto = vim.tbl_extend("error", config, {name})
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  plugins = tbl_17_auto
end
local lazy = require("lazy")
return lazy.setup(plugins)