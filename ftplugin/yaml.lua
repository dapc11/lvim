local bufnr = vim.api.nvim_get_current_buf()

require("which-key").register({
  ["<leader>c"] = { name = "+Yaml", buffer = bufnr },
  ["<leader>cf"] = {
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
  ["<leader>cv"] = {
    "<cmd>YAMLYankValue<cr>",
    "Yank value",
    mode = { "n" },
    buffer = bufnr,
  },
  ["<leader>ck"] = {
    "<cmd>YAMLYankKey<cr>",
    "Yank Key",
    mode = { "n" },
    buffer = bufnr,
  },
  ["<leader>cy"] = {
    "<cmd>YAMLYank<cr>",
    "Yank",
    mode = { "n" },
    buffer = bufnr,
  },
})
