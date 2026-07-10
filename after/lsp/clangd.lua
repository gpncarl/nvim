return {
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr);
    if require("utils").bufname_valid(name) then
      local dir = vim.fs.root(name, { {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac'   -- AutoTools
      }, '.git' })
      on_dir(dir)
    end
  end
}
