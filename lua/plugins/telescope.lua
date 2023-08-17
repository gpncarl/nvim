local function config()
    local telescope = require("telescope")
    local actions = require("telescope.actions.layout")
    telescope.setup {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        },
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = { i = { ["<C-_>"] = actions.toggle_preview } },
            sorting_strategy = "ascending",
            -- layout_strategy = "horizontal",
            -- layout_config = { prompt_position = "top", preview_width = 0.6, height = 0.5, width = 0.8 },
            layout_config = { prompt_position = "top" },
            -- layout_config = { prompt_position = "top", mirror = true, anchor = "N" },
            border = true,
            preview = { hide_on_startup = true }
        }
    }

    telescope.load_extension("fzf")
    -- telescope.load_extension("ui-select")
    -- telescope.load_extension("harpoon")
    -- local function fuzzy(name, opts)
    --     -- local default_opts = require("telescope.themes").get_dropdown({ push_cursor_on_edit = true, winblend = 10 })
    --     local default_opts = {}
    --     local builtin = require("telescope.builtin")
    --     local result = vim.tbl_extend("keep", (opts or {}), default_opts)
    --     return function(...)
    --         return builtin[name](result, ...)
    --     end
    -- end
    -- local function nmap(...)
    --     return vim.keymap.set("n", ...)
    -- end
    -- nmap("<space>fo", function() fuzzy("treesitter") { buffer = 0 } end, { desc = "fuzzy outline" })
    -- nmap("<space>ff", fuzzy("find_files"), { desc = "fuzzy files" })
    -- nmap("<space>gf", fuzzy("git_files", { show_untracked = false }), { desc = "fuzzy git files" })
    -- nmap("<space>m", fuzzy("oldfiles"), { desc = "fuzzy oldfiles" })
    -- nmap("<space>b", fuzzy("buffers"), { desc = "fuzzy buffers" })
    -- nmap("<leader>gr", fuzzy("grep_string"), { desc = "fuzzy string" })
    -- nmap("<space>gr", fuzzy("live_grep"), { desc = "live fuzzy string" })
    -- nmap("<space>j", fuzzy("jumplist"), { desc = "fuzzy jumplist" })
    -- nmap("<space>q", fuzzy("quickfix"), { desc = "fuzzy quickfix" })
    -- nmap("<space>l", fuzzy("loclist"), { desc = "fuzzy loclist" })
    -- nmap("<space>re", fuzzy("resume"), { desc = "fuzzy resume" })
    -- nmap("<space>ab", fuzzy("builtin"), { desc = "fuzzy all built-in" })
    -- nmap("<space>ap", fuzzy("pickers"), { desc = "fuzzy all pickers" })
    -- nmap("<space>ht", function() telescope.extensions.harpoon.marks() end, { desc = "fuzzy harpoon marks" })
end

return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<space>fo",  "<cmd>Telescope treesitter buffer=0<cr>",        desc = "fuzzy outline" },
            { "<space>ff",  "<cmd>Telescope find_files<cr>",                 desc = "fuzzy files" },
            { "<space>gf",  "<cmd>Telescope git_files show_untracked=false", desc = "fuzzy git files" },
            { "<space>m",   "<cmd>Telescope oldfiles<cr>",                   desc = "fuzzy oldfiles" },
            { "<space>b",   "<cmd>Telescope buffers<cr>",                    desc = "fuzzy buffers" },
            { "<leader>gr", "<cmd>Telescope grep_string<cr>",                desc = "fuzzy string" },
            { "<space>gr",  "<cmd>Telescope live_grep<cr>",                  desc = "live fuzzy string" },
            { "<space>j",   "<cmd>Telescope jumplist<cr>",                   desc = "fuzzy jumplist" },
            { "<space>q",   "<cmd>Telescope quickfix<cr>",                   desc = "fuzzy quickfix" },
            { "<space>l",   "<cmd>Telescope loclist<cr>",                    desc = "fuzzy loclist" },
            { "<space>re",  "<cmd>Telescope resume<cr>",                     desc = "fuzzy resume" },
            { "<space>ab",  "<cmd>Telescope builtin<cr>",                    desc = "fuzzy all built-in" },
            { "<space>ap",  "<cmd>Telescope pickers<cr>",                    desc = "fuzzy all pickers" },
        },
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- "nvim-telescope/telescope-ui-select.nvim",
            -- "ThePrimeagen/harpoon"
        },
        config = config
    }
}
