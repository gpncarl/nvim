return {
    {
        "chentoast/marks.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
           require"marks".setup({})
           vim.api.nvim_set_hl(0, "MarkSignHL", { link = "CursorLineNr"})
           vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "Identifier"})
        end
    }
}
