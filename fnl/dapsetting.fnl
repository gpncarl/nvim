(local dap (require :dap))
(dap.adapters.cppdbg {
    ::id "cppdbg"
    ::type "executable"
    ::command "/Users/carl/.vscode/extensions/ms-vscode.cpptools-1.11.5-darwin-x64/debugAdapters/bin/OpenDebugAD7"
    ::args []
})

(set dap.configurations.cpp [
    {
        :name "Launch file",
        :type "cppdbg",
        :request "launch",
        :program (partial vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) "/") "file")
        :MIMode "gdb"
        :miDebuggerPath "/usr/local/bin/gdb"
        :cwd "${workspaceFolder}"
        :stopAtEntry true
        :stopAtConnect true
        :setupCommands {  
            { 
                :text "-enable-pretty-printing"
                :description "enable pretty printing"
                :ignoreFailures false 
            }
        }
    }
    {
        :name "Attach to gdbserver :4711"
        :type "cppdbg"
        :request "launch"
        :MIMode "gdb"
        :miDebuggerServerAddress "localhost:4711"
        :miDebuggerPath "/usr/local/bin/gdb"
        :cwd "${workspaceFolder}"
        :program (partial vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) "/") "file")
        :setupCommands {  
            { 
                :text "-enable-pretty-printing"
                :description  "enable pretty printing",
                :ignoreFailures false 
            }
        }
    }
])
(set dap.configurations.c dap.configurations.cpp)
(set dap.configurations.rust dap.configurations.cpp)
