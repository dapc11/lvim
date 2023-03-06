lvim.leader = "space"
vim.cmd([[
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", '"Nn"[v:searchforward]', {
  expr = true,
  noremap = true,
  desc = "Better forward N behaviour",
})
vim.keymap.set("n", "N", '"nN"[v:searchforward]', {
  expr = true,
  noremap = true,
  desc = "Better backward N behaviour",
})

-- stolen from justinmk
vim.keymap.set("n", "/", "ms/", { desc = "Keeps jumplist after forward searching" })
vim.keymap.set("n", "?", "ms?", { desc = "Keeps jumplist after backward searching" })

vim.keymap.set({ "n", "v", "x", "o" }, "ä", "}zz")
vim.keymap.set({ "n", "v", "x", "o" }, "ö", "{zz")
vim.keymap.set({ "n", "v", "x", "o" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v", "x", "o" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "o", "x" }, "<", "]", { noremap = false })
vim.keymap.set({ "n", "o", "x" }, ">", "[", { noremap = false })
vim.keymap.set("n", "<c", function()
  if vim.wo.diff then
    return "]czz"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
    vim.fn.feedkeys("zz")
  end)
  return "<Ignore>"
end, { expr = true })

vim.keymap.set("n", ">c", function()
  if vim.wo.diff then
    return "[czz"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
    vim.fn.feedkeys("zz")
  end)
  return "<Ignore>"
end, { expr = true })

require("leap").add_default_mappings()
vim.keymap.set("o", "m", require("tsht").nodes, { noremap = false })
vim.keymap.set("x", "m", require("tsht").nodes, { noremap = true })

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
lvim.keys.insert_mode["<C-v>"] = "<esc>pi"

lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<A-a>"] = "<C-a>"
lvim.keys.normal_mode["<A-x>"] = "<C-x>"
lvim.keys.normal_mode["<C-g>"] = "<cmd>tab Git<CR>"
lvim.keys.normal_mode["<C-f>"] = require("telescope.builtin").current_buffer_fuzzy_find
lvim.keys.normal_mode["<C-p>"] = function()
  require("telescope").extensions.projects.projects(require("telescope.themes").get_ivy({ previewer = false }))
end
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
lvim.keys.normal_mode["<d"] = function()
  vim.diagnostic.goto_next({
    float = false,
  })
end
lvim.keys.normal_mode[">d"] = function()
  vim.diagnostic.goto_prev({
    float = false,
  })
end
lvim.keys.normal_mode["W"] = ":noautocmd w<CR>"
lvim.keys.visual_mode["<A-a>"] = "<C-a>"
lvim.keys.visual_mode["<A-x>"] = "<C-x>"
lvim.keys.visual_mode["<S-Down>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<S-Up>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode["c"] = '"_c'
lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_block_mode["p"] = "pgvy"
vim.keymap.set("n", "<C-Left>", "<Nop>")
vim.keymap.set("n", "<C-Right>", "<Nop>")
vim.keymap.set("n", "<C-Up>", "<Nop>")
vim.keymap.set("n", "<C-Down>", "<Nop>")

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

local tb = require("telescope.builtin")
lvim.builtin.which_key.vmappings["f"] = {
  function()
    local text = vim.getVisualSelection()
    tb.current_buffer_fuzzy_find({ default_text = text })
  end,
  "Current Buffer Grep Selection",
}

lvim.builtin.which_key.vmappings["<leader>"] = {
  function()
    local text = vim.getVisualSelection()
    tb.live_grep({ default_text = text })
  end,
  "Live Grep Selection",
}
