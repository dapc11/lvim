local bufnr = vim.api.nvim_get_current_buf()
local opts = {
  mode = "n", -- VISUAL mode
  prefix = "<leader>",
  buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Yaml",
    p = { "<Cmd>YAMLView<CR>", "View full path of current key/value" },
    y = { "<Cmd>YAMLYank<CR>", "Yank full path and value" },
    k = { "<Cmd>YAMLYankKey<CR>", "Yank full path of key" },
    v = { "<Cmd>YAMLYankValue<CR>", "Yank value of current key" },
    q = { "<Cmd>YAMLQuickfix<CR>", "All Entries to QF" },
    f = { "<Cmd>YAMLTelescope<CR>", "Telescope" },
  },
}
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("Couldn't import which-key")
  return
end
which_key.register(mappings, opts)
