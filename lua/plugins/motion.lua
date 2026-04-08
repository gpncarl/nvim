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
    "https://codeberg.org/andyg/leap.nvim",
    keys = {
      { "s", "<Plug>(leap-forward)",  mode = { "n", "x", "o" }, desc = "Leap forward", },
      { "S", "<Plug>(leap-backward)", mode = { "n", "x", "o" }, desc = "Leap backward", },
      {
        "<cr>",
        function()
          vim.v.hlsearch = false
          require("leap").leap({
            pattern = vim.fn.getreg("/"),
            backward = vim.v.searchforward == 0,
            opts = { vim_opts = { ["go.smartcase"] = true, }, }
          })
        end,
        mode = { "n", "x", "o" },
        desc = "Leap last search",
      },
    },
    dependencies = { "tpope/vim-repeat" },
    init = function()
      local au = function(event, pattern, callback, desc)
        vim.api.nvim_create_autocmd(event, { pattern = pattern, group = require("utils").augroup("leap_last_search"), callback = callback, desc = desc })
      end
      local revert_cr = function() vim.keymap.set('n', '<cr>', '<cr>', { buffer = true }) end
      au('FileType', 'qf', revert_cr, 'Revert <cr>')
      au('CmdwinEnter', '*', revert_cr, 'Revert <cr>')
    end,
    config = function()
      local opts = require("leap").opts
      opts.keys.next_target = { ";" }
      opts.keys.prev_target = { "," }
      opts.preview = false
    end,
  }
}
