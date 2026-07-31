return {
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    config = function()
      require("mini.misc").safely("event:InsertEnter", function()
        require("mini.pairs").setup()
      end)
      require("mini.icons").setup({
        extension = {
          h = { glyph = "" },
          hh = { glyph = "" },
          hpp = { glyph = "" },
          c = { glyph = "" },
          cc = { glyph = "" },
          cpp = { glyph = "" },
          cppm = { glyph = "" },
        },
        lsp = {
          tabnine = { glyph = "⌬" },
          copilot = { glyph = "" },
          supermaven = { glyph = "" },
        }
      })
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.statusline").setup()
      require("mini.tabline").setup()

      require("mini.misc").safely("later", function()
        require("mini.trailspace").setup()
        require("mini.surround").setup({
          mappings = {
            add = "ys",
            delete = "ds",
            replace = "cs",
            find = "",
            find_left = "",
            highlight = "",
            suffix_last = "",
            suffix_next = "",
          },
          search_method = "cover_or_next",
        })
        vim.keymap.del("x", "ys")
        vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
        vim.keymap.set("n", "yss", "ys_", { remap = true })

        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
          highlighters = {
            fixme     = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack      = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo      = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note      = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
            hex_color = hipatterns.gen_highlighter.hex_color(),
          },
        })

        if vim.g.user_picker == "mini.pick" then
          require("mini.extra").setup()
          require("mini.pick").setup({
            window = {
              config = function()
                local height = math.floor((1 - 0.618) * vim.o.lines)
                local width = vim.o.columns
                return {
                  anchor = "NW",
                  height = height,
                  width = width,
                  row = math.floor(vim.o.lines - height),
                  col = 0,
                }
              end,
            },
            options = {
              content_from_bottom = true,
            }
          })
          local function src(opts)
            return opts.cwd and { source = { cwd = opts.cwd } } or {}
          end
          local function extra(name, local_opts)
            return function(opts) return require("mini.extra").pickers[name](local_opts, src(opts)) end
          end
          require("utils.picker").register("mini.pick", {
            resolve = function(name)
              return function(opts) return require("mini.pick").builtin[name](nil, src(opts)) end
            end,
            overrides = {
              live_grep             = "grep_live",
              grep_string           = function(opts)
                return require("mini.pick").builtin.grep({ pattern = vim.fn.expand("<cword>") }, src(opts))
              end,
              resume                = function() return require("mini.pick").builtin.resume() end,
              oldfiles              = extra("oldfiles"),
              treesitter            = extra("treesitter"),
              lsp_definitions       = extra("lsp", { scope = "definition" }),
              lsp_declarations      = extra("lsp", { scope = "declaration" }),
              lsp_references        = extra("lsp", { scope = "references" }),
              lsp_implementations   = extra("lsp", { scope = "implementation" }),
              lsp_type_definitions  = extra("lsp", { scope = "type_definition" }),
              lsp_document_symbols  = extra("lsp", { scope = "document_symbol" }),
              lsp_workspace_symbols = extra("lsp", { scope = "workspace_symbol" }),
            },
          })
        end
      end)
    end,
  },
}
