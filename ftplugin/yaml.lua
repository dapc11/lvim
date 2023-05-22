local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  ["<leader>C"] = { name = "+Yaml" },
  ["<leader>Cf"] = {
    ":%!yq '.'",
    "Format",
    mode = { "v", "n" },
    buffer = bufnr,
  },
  ["<leader>fy"] = {
    function()
      require("user.telescopefinders").yaml_find()
    end,
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
