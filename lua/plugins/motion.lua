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
        function()
          require("jumph").count_label(vim.fn.getreg("/"))
        end,
        mode = { "n", "x", "o" },
        desc = "Jumph: add count lable to last search",
      },
    },
    opts = {},
  },
}
