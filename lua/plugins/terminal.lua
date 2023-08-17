return {
    {
        "akinsho/toggleterm.nvim",
        cmd = {
            "ToggleTerm",
            "ToggleTermToggleAll",
            "TermExec",
            "TermSelect",
            "ToggleTermSendCurrentLine",
            "ToggleTermSendVisualLines",
            "ToggleTermSendVisualSelection",
            "ToggleTermSetName"
        },
        keys = { "<c-\\><c-\\>" },
        opts = { open_mapping = "<c-\\><c-\\>" }
    },
}
