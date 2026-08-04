return {
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    keys = {
      { "<leader>H", "<cmd>Grapple tag<cr>",         desc = "Grapple add tag" },
      { "<leader>h",   "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
    },
    opts = {},
  },
  {
    "tpope/vim-projectionist",
    event = { "VeryLazy" },
    config = function()
      vim.g.projectionist_heuristics = {
        ["*"] = {
          ["*.cpp"] = {
            ["alternate"] = {
              "{}.h",
              "{}.hpp"
            }
          },
          ["*.cc"] = {
            ["alternate"] = {
              "{}.h",
              "{}.hh"
            }
          },
          ["*.c"] = {
            ["alternate"] = {
              "{}.h"
            }
          },
          ["*.h"] = {
            ["alternate"] = {
              "{}.c",
              "{}.cc",
              "{}.cpp"
            }
          }
        }
      }
    end,
  },
}
