local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "gf", "<cmd>PytrizeJumpFixture<Cr>", "Jump To Fixture", bufnr)
map("n", "<leader>Dm", "<cmd>lua require('dap-python').test_method()<cr>", "Test Method", bufnr)
map("n", "<leader>Df", "<cmd>lua require('dap-python').test_class()<cr>", "Test Class", bufnr)
map("n", "<leader>Ds", "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection", bufnr)

pcall(function()
  require("dap-python").test_runner = "pytest"
end)
