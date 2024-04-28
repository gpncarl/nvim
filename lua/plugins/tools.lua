local config = require "config"
return {
    {
        "luckasRanarison/nvim-devdocs",
        cmd = {
            "DevdocsFetch",
            "DevdocsInstall",
            "DevdocsUninstall",
            "DevdocsOpen",
            "DevdocsOpenFloat",
            "DevdocsOpenCurrent",
            "DevdocsOpenCurrentFloat",
            "DevdocsUpdate",
            "DevdocsUpdateAll"
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- previewer_cmd = "glow",
            -- cmd_args = { "-s", "dark", "-w", "80" },
        },
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "vhyrro/luarocks.nvim" },
        config = function()
            require("rest-nvim").setup()
        end,
    },
    {
        "kawre/leetcode.nvim",
        cond = config.leetcode,
        cmd = "Leet",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            cn = { enabled = true },
            injector = {
                ["python3"] = {
                    before = true
                },
                ["cpp"] = {
                    before = { "#include <bits/stdc++.h>", "using namespace std;" },
                    after = "int main() {}",
                },
                ["java"] = {
                    before = "import java.util.*;",
                },
            }
        },
    }
}
