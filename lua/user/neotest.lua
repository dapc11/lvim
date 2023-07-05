local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

neotest.setup({
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet", "-vvv" },
      runner = "pytest",
    }),
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
      args = { "-count=1", "-json", "-timeout=60s" },
    }),
  },
  icons = {
    running = "羽",
  },
  summary = {
    enabled = true,
    follow = true,
    expand_errors = true,
  },
  output_panel = { enabled = true },
  quickfix = {
    enabled = false,
    open = false,
  },
})
