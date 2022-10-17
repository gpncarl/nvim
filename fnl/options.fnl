(set vim.opt.cmdheight 1)
(set vim.opt.updatetime 100)
(set vim.opt.fixendofline false)
(set vim.opt.scrolloff 10)
(set vim.opt.tabstop 4)
(set vim.opt.shiftwidth 4)
(set vim.opt.signcolumn :yes)
(set vim.opt.inccommand :nosplit)
(set vim.opt.mouse :n)
(set vim.opt.laststatus 2)
(set vim.opt.hlsearch true)
(set vim.opt.showmode true)
(set vim.opt.wrapscan true)
(set vim.opt.termguicolors true)
(set vim.opt.incsearch true)
(set vim.opt.expandtab true)
(set vim.opt.autoindent true)
(set vim.opt.linebreak true)
(set vim.opt.cursorline false)
(set vim.opt.colorcolumn "")
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.smartindent true)
(set vim.opt.breakindent false)
(set vim.opt.autochdir false)
(set vim.opt.number false)
(set vim.opt.autowrite true)
(set vim.opt.autowriteall true)
(set vim.opt.relativenumber true)
(set vim.opt.splitright true)
(set vim.opt.hidden true)
(set vim.opt.showmatch true)
(set vim.opt.breakindentopt :shift:4)
(set vim.opt.clipboard :unnamedplus)
(set vim.opt.cinoptions "l1,N-s,E-s,t0,(0,w1,W4")
(set vim.opt.showbreak :↪)
(set vim.opt.background :light)
(set vim.opt.guifont "FiraCode Nerd Font Mono:h14")
(set vim.opt.completeopt "menuone,noinsert,noselect")
(set vim.opt.grepprg "ug -RInkus --tabs=4 --ignore-files") ;; vim.opt.grepprg = 'rg --vimgrep --no-heading'
(set vim.opt.grepformat "%f:%l:%c:%m,%f+%l+%c+%m,%-G%f|%l|%c|%m") ;; vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

(vim.opt.shortmess:append  { :I true })
(vim.opt.cpoptions:append { :n true })
(vim.opt.sessionoptions:append :winpos)
(vim.opt.path:append :**)
