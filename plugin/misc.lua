MiniMisc.safely("later", function()
  require("vim._core.ui2").enable({
    enable = false,
    msg = {
      targets = "msg",
    }
  })
end)
