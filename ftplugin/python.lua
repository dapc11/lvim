local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "gf", "<cmd>PytrizeJumpFixture<Cr>", "Jump To Fixture", bufnr)
map("n", "<leader>Dm", "<cmd>lua require('dap-python').test_method()<cr>", "Test Method", bufnr)
map("n", "<leader>Df", "<cmd>lua require('dap-python').test_class()<cr>", "Test Class", bufnr)
map("n", "<leader>Ds", "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection", bufnr)
map("n", "<leader>Ci", "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env", bufnr)
map("n", "<leader>Cd", "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env", bufnr)

pcall(function()
  require("dap-python").test_runner = "pytest"
end)
