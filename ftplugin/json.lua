local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "<leader>Cf", ":%!jq '.'", "Format", bufnr)
map("v", "<leader>Cf", ":%!jq '.'", "Format", bufnr)
