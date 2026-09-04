return {
  {
    "tpope/vim-projectionist",
    init = function()
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
