local bufnr = vim.api.nvim_get_current_buf()

require("which-key").register({
  ["<leader>c"] = { name = "+Bash", buffer = bufnr },
})
