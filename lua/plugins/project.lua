return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        keys = {
            {
                "<C-S-H>",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon File",
            },
            {
                "<C-H>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Quick Menu",
            },
        },
        opts = {
            settings = {
                save_on_toggle = true,
            },
        },
        config = function(_, opts)
            local harpoon = require("harpoon")
            harpoon:extend({
                UI_CREATE = function(cx)
                    vim.keymap.set("n", "<C-CR>", function()
                        harpoon.ui:select_menu_item()
                    end, { buffer = cx.bufnr })
                end,
            })
            harpoon:setup(opts)
        end
    }
}
