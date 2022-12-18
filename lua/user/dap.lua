local dap = require("dap")
local dapui = require("dapui")
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = {
    function()
      dap.toggle_breakpoint()
    end,
    "Breakpoint",
  },
  c = {
    function()
      dap.continue()
    end,
    "Continue",
  },
  i = {
    function()
      dap.step_into()
    end,
    "Into",
  },
  o = {
    function()
      dap.step_over()
    end,
    "Over",
  },
  O = {
    function()
      dap.step_out()
    end,
    "Out",
  },
  r = {
    function()
      dap.repl.toggle()
    end,
    "Repl",
  },
  l = {
    function()
      dap.run_last()
    end,
    "Last",
  },
  u = {
    function()
      dapui.toggle()
    end,
    "UI",
  },
  x = {
    function()
      dap.terminate()
    end,
    "Exit",
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
