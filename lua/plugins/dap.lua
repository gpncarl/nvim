return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            return require("dapsetting")
        end
    },
}
