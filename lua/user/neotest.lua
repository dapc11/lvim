require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
    }),
    require("neotest-go"),
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
