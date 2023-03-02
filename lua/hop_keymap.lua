local hop = require("hop")
local hint = require("hop.hint")
local map
local function _1_(...)
  return vim.keymap.set("", ...)
end
map = _1_
local _3_
do
  local _2_ = {direction = hint.HintDirection.AFTER_CURSOR}
  local function _4_(...)
    return hop.hint_char1(_2_, ...)
  end
  _3_ = _4_
end
map("<leader><leader>F", _3_, {desc = "search one char before cursor"})
local _6_
do
  local _5_ = {direction = hint.HintDirection.AFTER_CURSOR}
  local function _7_(...)
    return hop.hint_char1(_5_, ...)
  end
  _6_ = _7_
end
map("<leader><leader>f", _6_, {desc = "search one char after cursor"})
local _9_
do
  local _8_ = {direction = hint.HintDirection.BEFORE_CURSOR}
  local function _10_(...)
    return hop.hint_char2(_8_, ...)
  end
  _9_ = _10_
end
map("<leader><leader>S", _9_, {desc = "search two char before cursor"})
local _12_
do
  local _11_ = {direction = hint.HintDirection.AFTER_CURSOR}
  local function _13_(...)
    return hop.hint_char2(_11_, ...)
  end
  _12_ = _13_
end
map("<leader><leader>s", _12_, {desc = "search two char after cursor"})
local _15_
do
  local _14_ = {direction = hint.HintDirection.AFTER_CURSOR, hint_position = hint.HintPosition.BEGIN}
  local function _16_(...)
    return hop.hint_words(_14_, ...)
  end
  _15_ = _16_
end
map("<leader><leader>w", _15_, {desc = "word begin after cursor"})
local _18_
do
  local _17_ = {direction = hint.HintDirection.BEFORE_CURSOR, hint_position = hint.HintPosition.BEGIN}
  local function _19_(...)
    return hop.hint_words(_17_, ...)
  end
  _18_ = _19_
end
map("<leader><leader>b", _18_, {desc = "word begin before cursor"})
local _21_
do
  local _20_ = {direction = hint.HintDirection.AFTER_CURSOR, hint_position = hint.HintPosition.END}
  local function _22_(...)
    return hop.hint_words(_20_, ...)
  end
  _21_ = _22_
end
map("<leader><leader>e", _21_, {desc = "word end after cursor"})
local _24_
do
  local _23_ = {direction = hint.HintDirection.BEFORE_CURSOR, hint_position = hint.HintPosition.END}
  local function _25_(...)
    return hop.hint_words(_23_, ...)
  end
  _24_ = _25_
end
map("<leader><leader>ge", _24_, {desc = "word end before cursor"})
map("<leader><leader>q", hop.hint_patterns, {desc = "query"})
local _27_
do
  local _26_ = {direction = hint.HintDirection.AFTER_CURSOR}
  local function _28_(...)
    return hop.hint_lines(_26_, ...)
  end
  _27_ = _28_
end
map("<leader><leader>j", _27_, {desc = "line start after cursor"})
local _30_
do
  local _29_ = {direction = hint.HintDirection.BEFORE_CURSOR}
  local function _31_(...)
    return hop.hint_lines(_29_, ...)
  end
  _30_ = _31_
end
map("<leader><leader>k", _30_, {desc = "line start before cursor"})
local _33_
do
  local _32_ = {direction = hint.HintDirection.AFTER_CURSOR}
  local function _34_(...)
    return hop.hint_lines_skip_whitespace(_32_, ...)
  end
  _33_ = _34_
end
map("<leader><leader>J", _33_, {desc = "line head after cursor"})
local _36_
do
  local _35_ = {direction = hint.HintDirection.BEFORE_CURSOR}
  local function _37_(...)
    return hop.hint_lines_skip_whitespace(_35_, ...)
  end
  _36_ = _37_
end
return map("<leader><leader>K", _36_, {desc = "line head before cursor"})