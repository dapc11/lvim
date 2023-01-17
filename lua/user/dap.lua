local dap = require("dap")
local dapui = require("dapui")

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
