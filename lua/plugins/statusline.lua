local config = require "config"
local function setup()
    local lualine = require("lualine")
    return lualine.setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            disabled_filetypes = { statusline = {}, winbar = {} },
            ignore_focus = {},
            always_divide_middle = true,
            refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
            globalstatus = true
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "%S", "searchcount", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        extensions = { "quickfix", "fugitive" }
    })
end

local function get_fold()
    local fcs = vim.opt.fillchars:get()
    local lnum = vim.v.lnum

    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end

    return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end

return {
    {
        "hoob3rt/lualine.nvim",
        event = "ColorScheme",
        config = setup
    },
    {
        "akinsho/bufferline.nvim",
        event = "ColorScheme",
        cond = config.bufferline,
        opts = {
            options = {
                mode = "buffers",
                numbers = "buffer_id",
                separator_style = "slant",
                sort_by = "id",
            }
        }
    },
    {
        "Bekaboo/dropbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        cond = config.dropbar,
        opts = {
            bar = {
                sources =
                    function(buf, _)
                        local sources = require('dropbar.sources')
                        local utils = require('dropbar.utils')
                        if vim.bo[buf].ft == 'markdown' then
                            return {
                                utils.source.fallback({
                                    sources.treesitter,
                                    sources.markdown,
                                    sources.lsp,
                                }),
                            }
                        end
                        if vim.bo[buf].buftype == 'terminal' then
                            return {
                                sources.terminal,
                            }
                        end
                        return {
                            utils.source.fallback({
                                sources.lsp,
                                sources.treesitter,
                            }),
                        }
                    end
            }
        }
    },
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = {
            icons = require("utils.icons").kinds
        }
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup({
                relculright = true,
                bt_ignore = { 'terminal' },
                ft_ignore = { 'oil', 'alpha', 'qf', '' },
                segments = {
                    {
                        text = { get_fold },
                        hl = "Folded",
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = { namespace = { "gitsigns" }, fillchar = "│", colwidth = 1, wrap = true },
                        click = "v:lua.ScSa"
                    },
                    {
                        sign = { namespace = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true },
                        click = "v:lua.ScSa"
                    },
                    { text = { "%=%{v:relnum}", " " }, click = "v:lua.ScLa", },
                }
            })
        end,
    }
}
