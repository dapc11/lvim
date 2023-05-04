local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  ["<leader>C"] = { name = "+Json" },
  ["<leader>Cf"] = {
    ":%!jq '.'",
    "Format",
    mode = { "v", "n" },
    buffer = bufnr,
  },
})
