local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  ["K"] = { vim.lsp.buf.hover, "Preview a Linked Note", buffer = bufnr },
  ["gd"] = { vim.lsp.buf.definition, "Follow Link", buffer = bufnr },
  ["<leader>zL"] = { vim.cmd.ZkBacklinks, "Open Notes Linking to Buffer", buffer = bufnr },
  ["<leader>zf"] = { vim.lsp.buf.definition, "Follow Link", buffer = bufnr },
  ["<leader>za"] = { ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", "Code Actions", buffer = bufnr, mode = "v" },
  ["<leader>zl"] = { vim.cmd.ZkLinks, "Open Notes Linked by the Buffer", buffer = bufnr, mode = { "v", "n" } },
})
vim.cmd([[
setlocal wrap spell spelllang=en_us
]])

vim.keymap.set("n", "<s", "]s", { buffer = bufnr })
vim.keymap.set("n", ">s", "[s", { buffer = bufnr })
