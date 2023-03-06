local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map

-- Open the link under the caret.
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Preview a Linked Note", bufnr)

local wk = require("which-key")
wk.register({
  z = {
    name = "Zettelkasten",
    b = { "<Cmd>ZkBacklinks<CR>", "Open Notes Linking to Buffer" },
    l = { "<Cmd>ZkLinks<CR>", "Open Notes Linked by the Buffer" },
    f = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Follow Link" }
  },
}, { prefix = "<leader>", buffer = bufnr, mode = "n" })
wk.register({
  z = {
    name = "Zettelkasten",
    a = { ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", "Code Actions" },
    l = { "<Cmd>ZkLinks<CR>", "Open Notes Linked by the Buffer" },
  },
}, { prefix = "<leader>", buffer = bufnr, mode = "v" })
