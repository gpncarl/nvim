return {
  {
    "bkad/CamelCaseMotion",
    keys = function()
      vim.g.camelcasemotion_key = "\\"
      local key_spec = {}
      for _, key in ipairs({ "w", "b", "e", "ge" }) do
        key_spec[#key_spec + 1] = {
          vim.g.camelcasemotion_key .. key,
          mode = { "n", "v", "o" },
          desc = "camel case " .. key
        }
        key_spec[#key_spec + 1] = {
          "i" .. vim.g.camelcasemotion_key .. key,
          mode = { "v", "o" }
        }
      end
      return key_spec
    end
  },
  {
    "local/jumph",
    dev = true,
    keys = {
      {
        "<cr>",
        function() require("jumph").jump(vim.fn.getreg("/"), vim.v.searchforward == 1) end,
        mode = { "n", "x", "o" },
        desc = "Jumph: jump to last search",
      },
    },
    init = function()
      local au = function(event, pattern, callback, desc)
        vim.api.nvim_create_autocmd(event, { pattern = pattern, group = require("utils").augroup("jumph"), callback = callback, desc = desc })
      end
      local revert_cr = function() vim.keymap.set('', '<cr>', '<cr>', { buffer = true }) end
      au('FileType', 'qf', revert_cr, 'Revert <cr>')
      au('CmdwinEnter', '*', revert_cr, 'Revert <cr>')
    end,
    opts = {},
  }
}
