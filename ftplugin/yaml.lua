local bufnr = vim.api.nvim_get_current_buf()
local map = function(mode, lhs, rhs, desc)
  if desc then
    desc = desc
  end

  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
end
map("n", "<leader>Cf", ":%!yq '.'", "Format")
map("v", "<leader>Cf", ":%!yq '.'", "Format")
map("n", "<leader>fy", ':lua require("user.telescope").yaml_find()<CR>', "Find yaml")
