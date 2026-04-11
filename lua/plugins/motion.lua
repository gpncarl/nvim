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
    "gpncarl/jumph.nvim",
    keys = {
      {
        "<cr>",
        function()
          require("jumph").count_label(vim.fn.getreg("/"))
        end,
        mode = { "n", "x" },
        desc = "Jumph: add count lable to last search",
      },
    },
    init = function()
      local jumph_group = vim.api.nvim_create_augroup("jumph", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
          pattern = "qf",
          group = jumph_group,
          callback = function()
            vim.keymap.set('', '<cr>', '<cr>', { buffer = true })
          end,
          desc = "Revert <cr>"
      })

      vim.api.nvim_create_autocmd("CmdwinEnter", {
          pattern = "*",
          group = jumph_group,
          callback = function()
            vim.keymap.set('', '<cr>', '<cr>', { buffer = true })
          end,
          desc = "Revert <cr>"
      })
    end,
    opts = {},
  },
}
