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
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<A-a>"] = "<C-a>"
lvim.keys.normal_mode["<A-x>"] = "<C-x>"
lvim.keys.normal_mode["<C-Down>"] = "<C-W>j"
lvim.keys.normal_mode["<C-g>"] = ":LazyGit<CR>"
lvim.keys.normal_mode["<C-f>"] = function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end
lvim.keys.normal_mode["<C-j>"] = function()
  require("telescope.builtin").jumplist()
end
lvim.keys.normal_mode["<C-Left>"] = "<C-W>h"
lvim.keys.normal_mode["<C-p>"] = ":Telescope projects<CR>"
lvim.keys.normal_mode["<C-Right>"] = "<C-W>l"
lvim.keys.normal_mode["<C-Up>"] = "<C-W>k"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-Left>"] = ":bprev<CR>"
lvim.keys.normal_mode["<M-Right>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Down>"] = ":m .+1<CR>=="
lvim.keys.normal_mode["<S-Left>"] = ":tabprevious<CR>"
lvim.keys.normal_mode["<S-Right>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<S-Up>"] = ":m .-2<CR>=="
lvim.keys.normal_mode["<q"] = ":cnext<CR>"
lvim.keys.normal_mode[">q"] = ":cprevious<CR>"
lvim.keys.normal_mode["<l"] = ":lnext<CR>"
lvim.keys.normal_mode[">l"] = ":lprevious<CR>"
lvim.keys.normal_mode["<d"] = function()
  require("trouble").next({ skip_groups = true, jump = true })
end
lvim.keys.normal_mode[">d"] = function()
  require("trouble").previous({ skip_groups = true, jump = true })
end
lvim.keys.normal_mode["<g"] = "<cmd>Gitsigns next_hunk<CR>"
lvim.keys.normal_mode[">g"] = "<cmd>Gitsigns prev_hunk<CR>"
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
