vim.opt.spelllang = "en_us"
vim.opt.spell = true

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<s", "]s", { buffer = bufnr })
vim.keymap.set("n", ">s", "[s", { buffer = bufnr })
