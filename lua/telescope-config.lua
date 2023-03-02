local telescope = require("telescope")
local actions = require("telescope.actions.layout")
telescope.setup({extensions = {fzf = {fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case"}}, defaults = {mappings = {i = {["<C-_>"] = actions.toggle_preview}}, sorting_strategy = "ascending", layout_strategy = "horizontal", layout_config = {prompt_position = "top", preview_width = 0.6, height = 0.5, width = 0.8}, border = true, preview = {hide_on_startup = true}}})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("harpoon")
local fuzzy
local function _1_(name, opts)
  local default_opts = {push_cursor_on_edit = true, winblend = 10}
  local builtin = require("telescope.builtin")
  local result = vim.tbl_extend("keep", (opts or {}), default_opts)
  local function _2_(...)
    return builtin[name](result, ...)
  end
  return _2_
end
fuzzy = _1_
local nmap
local function _3_(...)
  return vim.keymap.set("n", ...)
end
nmap = _3_
local _5_
do
  local _4_ = {buffer = 0}
  local function _6_(...)
    return fuzzy("treesitter")(_4_, ...)
  end
  _5_ = _6_
end
nmap("<space>o", _5_, {desc = "fuzzy outline"})
nmap("<space>ff", fuzzy("find_files"), {desc = "fuzzy files"})
nmap("<space>gf", fuzzy("git_files", {show_untracked = false}), {desc = "fuzzy git files"})
nmap("<space>m", fuzzy("oldfiles"), {desc = "fuzzy oldfiles"})
nmap("<space>b", fuzzy("buffers"), {desc = "fuzzy buffers"})
nmap("<leader>r", fuzzy("grep_string"), {desc = "fuzzy string"})
nmap("<space>r", fuzzy("live_grep"), {desc = "live fuzzy string"})
nmap("<space>j", fuzzy("jumplist"), {desc = "fuzzy jumplist"})
nmap("<space>q", fuzzy("quickfix"), {desc = "fuzzy quickfix"})
nmap("<space>l", fuzzy("loclist"), {desc = "fuzzy loclist"})
local function _7_()
  return telescope.extensions.harpoon.marks()
end
return nmap("<space>ht", _7_, {desc = "fuzzy harpoon marks"})