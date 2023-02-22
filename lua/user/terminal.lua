vim.g.terminal_scrollback_buffer_size = 100000
vim.keymap.set("t", "<C-b>", "<C-\\><C-n>", {
  desc = "Get back to vim mode",
  silent = true,
})

-- Move between windows using Alt-
-- Ctrl- works only outside of terminal buffers
vim.keymap.set("t", "<A-Up>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<A-Down>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<A-Left>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<A-Right>", "<C-\\><C-n><C-w>l", { silent = true })

vim.keymap.set("n", "<Leader>xv", "<Cmd>vsplit term://$SHELL<CR>A", { desc = "Open terminal in a vsplit" })
vim.keymap.set("n", "<Leader>xs", "<Cmd>split term://$SHELL<CR>A", { desc = "Open terminal in a split" })
