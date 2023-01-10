local map = require("user.functions").map
lvim.leader = "space"

map("n", "<", "]", { noremap = false })
map("o", "<", "]", { noremap = false })
map("x", "<", "]", { noremap = false })
map("n", ">", "[", { noremap = false })
map("o", ">", "[", { noremap = false })
map("x", ">", "[", { noremap = false })
lvim.keys.normal_mode["<t"] = function()
	require("neotest").jump.next({ status = "failed" })
end
lvim.keys.normal_mode[">t"] = function()
	require("neotest").jump.prev({ status = "failed" })
end
lvim.keys.visual_mode["<Tab>"] = ">gv"
lvim.keys.visual_mode["<S-Tab>"] = "<gv"
lvim.keys.insert_mode["<S-Tab>"] = "<C-d>"
lvim.keys.insert_mode["<Tab>"] = "<C-t>"
lvim.keys.command_mode["<C-a>"] = "<Home>"
lvim.keys.command_mode["<C-BS>"] = "<C-W>"
lvim.keys.command_mode["<C-e>"] = "<End>"
lvim.keys.command_mode["<C-v>"] = "<C-r>0"
lvim.keys.command_mode["<M-BS>"] = "<C-W>"
lvim.keys.command_mode["<M-Left>"] = "<S-Left>"
lvim.keys.command_mode["<M-Right>"] = "<S-Right>"
lvim.keys.insert_mode["<C-a>"] = "<home>"
lvim.keys.insert_mode["<C-e>"] = "<end>"
lvim.keys.insert_mode["<C-v>"] = "<esc>pa"

lvim.keys.normal_mode["<c"] = "]c"
lvim.keys.normal_mode[">c"] = "[c"

lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<A-a>"] = "<C-a>"
lvim.keys.normal_mode["<A-x>"] = "<C-x>"
lvim.keys.normal_mode["<C-Down>"] = "<C-W>j"
lvim.keys.normal_mode["<C-g>"] = vim.cmd.LazyGit
lvim.keys.normal_mode["<C-f>"] = require("telescope.builtin").current_buffer_fuzzy_find
lvim.keys.normal_mode["<C-j>"] = require("telescope.builtin").jumplist
lvim.keys.normal_mode["<C-Left>"] = "<C-W>h"
lvim.keys.normal_mode["<C-p>"] = require("telescope").extensions.projects.projects
lvim.keys.normal_mode["<C-Right>"] = "<C-W>l"
lvim.keys.normal_mode["<C-Up>"] = "<C-W>k"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-Left>"] = vim.cmd.bprev
lvim.keys.normal_mode["<M-Right>"] = vim.cmd.bnext
lvim.keys.normal_mode["<S-Down>"] = ":m .+1<CR>=="
lvim.keys.normal_mode["<S-Left>"] = vim.cmd.tabprevious
lvim.keys.normal_mode["<S-Right>"] = vim.cmd.tabnext
lvim.keys.normal_mode["<S-Up>"] = ":m .-2<CR>=="
lvim.keys.normal_mode["<q"] = vim.cmd.cnext
lvim.keys.normal_mode[">q"] = vim.cmd.cprevious
lvim.keys.normal_mode["<l"] = vim.cmd.lnext
lvim.keys.normal_mode[">l"] = vim.cmd.lprevious
lvim.keys.normal_mode["<d"] = vim.diagnostic.goto_next
lvim.keys.normal_mode[">d"] = vim.diagnostic.goto_prev
lvim.keys.normal_mode["<g"] = require("gitsigns").next_hunk
lvim.keys.normal_mode[">g"] = require("gitsigns").prev_hunk
lvim.keys.normal_mode["ä"] = "}"
lvim.keys.normal_mode["ö"] = "{"
lvim.keys.normal_mode["W"] = ":noautocmd w<CR>"
lvim.keys.normal_mode["<"] = "]"
lvim.keys.normal_mode[">"] = "["
lvim.keys.visual_mode["<A-a>"] = "<C-a>"
lvim.keys.visual_mode["<A-x>"] = "<C-x>"
lvim.keys.visual_mode["<S-Down>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<S-Up>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode["ä"] = "}"
lvim.keys.visual_mode["c"] = '"_c'
lvim.keys.visual_mode["c"] = '"_c'
lvim.keys.visual_mode["ö"] = "{"
lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_block_mode["<"] = "]"
lvim.keys.visual_block_mode[">"] = "["
lvim.keys.visual_block_mode["p"] = "pgvy"
