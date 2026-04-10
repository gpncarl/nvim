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
        "s",
        function()
          vim.v.hlsearch = false
          require("jumph").jump(vim.fn.getreg("/"), true)
        end,
        mode = { "n", "x", "o" },
        desc = "Jumph: forward jump to last search",
      },
      {
        "S",
        function()
          vim.v.hlsearch = false
          require("jumph").jump(vim.fn.getreg("/"), false)
        end,
        mode = { "n", "x", "o" },
        desc = "Jumph: backward jump to last search",
      },
    },
    opts = {},
  },
  {
    "https://codeberg.org/andyg/leap.nvim",
    keys = {
      {
        "<cr>",
        function()
          local pattern = vim.fn.getreg("/")
          local forward = vim.v.searchforward == 1
          require("leap").leap({
            targets = vim.tbl_map(function(item)
              return { pos = { item.pos[1], item.pos[2] + 1 } }
            end, require("jumph").matcher(pattern, forward))
          })
        end,
        mode = { "n", "x", "o" },
        desc = "Flash: forward jump to last search",
      },
    },
    opts = {
      safe_labels = ''
    }
  }
}
