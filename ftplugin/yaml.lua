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
})
