local cl = require("utils").get_hl(0, { name = "CursorLine" })
local ln = require("utils").get_hl(0, { name = "LineNr" })
local cls = require("utils").get_hl(0, { name = "CursorLineSign" })
local clf = require("utils").get_hl(0, { name = "CursorLineFold" })

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = ln.fg, bg = cl.bg })
vim.api.nvim_set_hl(0, "CursorLineSign", { fg = cls.fg, bg = cl.bg })
vim.api.nvim_set_hl(0, "CursorLineFold", { fg = clf.fg, bg = cl.bg })

vim.api.nvim_set_hl(0, "MiniStatuscolumnSep", { link = "LineNr" })
vim.api.nvim_set_hl(0, "MiniStatuscolumnSepCursor", { link = "LineNr" })
