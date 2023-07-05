local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", ",", function()
  require("user.utils").run({ "bash" })
end, { buffer = bufnr })
