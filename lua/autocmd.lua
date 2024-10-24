local M = { has_stdin = false }

function M.setup()
  local augroup = require("utils").augroup

  -- Check if we need to reload the file when it changed
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end,
  })

  vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("termopen"),
    callback = function()
      vim.bo.bufhidden = "hide"
    end,
  })

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- resize splits if window got resized
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })

  -- go to last loc when opening a buffer
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
      local exclude = { "gitcommit" }
      local buf = event.buf
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
        return
      end
      vim.b[buf].lazyvim_last_loc = true
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- close some filetypes with <q>
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "notify",
      "qf",
      "gitgraph",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("tabclose_with_q"),
    pattern = {
      "DiffviewFiles"
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = event.buf, silent = true })
    end,
  })

  -- make it easier to close man-files when opened inline
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("no_wrap"),
    pattern = { "markdown", "vimwiki", "latex", "norg", "org" },
    callback = function()
      vim.opt_local.wrap = false
    end,
  })

  -- Fix conceallevel for json files
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
      vim.opt_local.conceallevel = 0
    end,
  })

  -- Auto create dir when saving a file, in case some intermediate directory does not exist
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
      if event.match:match("^%w%w+:[\\/][\\/]") then
        return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })

  vim.api.nvim_create_autocmd("QuickFixCmdPre", {
    group = augroup("quickfix"),
    command = "packadd cfilter"
  })

  vim.api.nvim_create_autocmd("StdinReadPre", {
    group = augroup("stdin"),
    callback = function()
      M.has_stdin = true
    end
  })

  vim.api.nvim_create_autocmd("UIEnter", {
    group = augroup("enter"),
    callback = function()
      if M.has_stdin then
        return
      end

      if vim.fn.argc() == 0 then
        vim.api.nvim_exec_autocmds("User", { pattern = "OpenDashboard" })
      end

      if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
        vim.api.nvim_exec_autocmds("User", { pattern = "OpenDirectory" })
      end
    end
  })

  vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    group = augroup("pad_margin_enter"),
    callback = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if not normal.bg then return end
      io.write(string.format("\027Ptmux;\027\027]11;#%06x\007\027\\", normal.bg))
    end,
  })

  vim.api.nvim_create_autocmd("UILeave", {
    group = augroup("pad_margin_leave"),
    callback = function()
      io.write("\027Ptmux;\027\027]111;\007\027\\")
    end,
  })

  vim.api.nvim_create_autocmd("BufRead", {
    group = augroup("last_place"),
    callback = function(opts)
      vim.api.nvim_create_autocmd("BufWinEnter", {
        once = true,
        buffer = opts.buf,
        callback = function()
          local ft = vim.bo[opts.buf].filetype
          local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
          if
              not (ft:match("commit") and ft:match("rebase"))
              and last_known_line > 1
              and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
          then
            vim.cmd([[normal! g`"zv]])
          end
        end,
      })
    end,
  })

  vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > 5 * 1024 * 1024 -- 5MB
            and "bigfile"
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

end

return M
