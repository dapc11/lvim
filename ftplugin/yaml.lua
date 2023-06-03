local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  ["<leader>lf"] = {
    ":%!yq '.'",
    "Format",
    mode = { "v", "n" },
    buffer = bufnr,
  },
  ["<leader>fk"] = {
    "<cmd>Telescope telescope-yaml<cr>",
    "YAML key",
    buffer = bufnr,
    mode = { "v", "n" },
  },
  ["<leader>lv"] = {
    "<cmd>YAMLYankValue<cr>",
    "Yank value",
    mode = { "n" },
    buffer = bufnr,
  },
  ["<leader>lk"] = {
    "<cmd>YAMLYankKey<cr>",
    "Yank Key",
    mode = { "n" },
    buffer = bufnr,
  },
  ["<leader>ly"] = {
    "<cmd>YAMLYank<cr>",
    "Yank",
    mode = { "n" },
    buffer = bufnr,
  },
})
