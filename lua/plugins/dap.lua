local function config()
    local dap = require('dap')
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/Users/carl/.vscode/extensions/ms-vscode.cpptools-1.11.5-darwin-x64/debugAdapters/bin/OpenDebugAD7',
        args = {}
    }

    local setupCommands = {
        {
            text = '-enable-pretty-printing',
            description = 'enable pretty printing',
            ignoreFailures = false
        },
    }
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            MIMode = "gdb",
            miDebuggerPath = "/usr/local/bin/gdb",
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
            stopAtConnect = true,
            setupCommands = setupCommands,
        },
        {
            name = "Attach to gdbserver :4711",
            type = "cppdbg",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:4711",
            miDebuggerPath = "/usr/local/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            setupCommands = setupCommands,
        }
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = config
    },
}
