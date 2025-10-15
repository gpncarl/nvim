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
    "folke/flash.nvim",
    keys = {
      {
        "g/",
        function() require("flash").jump() end,
        mode = { "n", "x", "o" },
        desc = "Flash",
      },
      {
        "gV",
        function() require("flash").treesitter() end,
        mode = { "n", "x", "o" },
        desc = "Flash Treesitter",
      },
    },
    opts = {
      modes = {
        char = { enabled = false },
      },
    },
  }
}
