local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "<leader>Cf", ":%!yq '.'", "Format", bufnr)
map("v", "<leader>Cf", ":%!yq '.'", "Format", bufnr)
map("n", "<leader>fy", function()
  require("user.telescope").yaml_find()
end, "Find yaml", bufnr)
