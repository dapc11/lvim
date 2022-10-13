local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
  D = {
    name = "Python Debug",
    m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method"},
    f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
    s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
  },
}
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end
which_key.register({D = "which_key_ignore", L = "which_key_ignore"})
which_key.register(mappings, opts)
