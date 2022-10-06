lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["<leader>"] = {
  ':lua require("telescope.builtin").live_grep({path_display={"truncate", shorten = {len = 3, exclude = {1,-1}}}})<CR>',
  "Live grep in current repo",
}

lvim.builtin.which_key.mappings["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" }
lvim.builtin.which_key.mappings["v"] = { "<cmd>vsplit<cr>", "vsplit" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope oldfiles<cr>", "Recent files" }
lvim.builtin.which_key.mappings["n"] = { ':lua require("telescope.builtin").git_files()<CR>', "Find in tracked files" }
lvim.builtin.which_key.mappings["N"] = {
  ':lua require("telescope.builtin").git_files({git_command={"git","ls-files","--modified","--exclude-standard"}})<CR>',
  "Find in unstaged files",
}
lvim.builtin.which_key.mappings["q"] = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" }
lvim.builtin.which_key.mappings["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" }
lvim.builtin.which_key.mappings["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" }

lvim.builtin.which_key.mappings["cd"] = { "<cmd>lua vim.diagnostic.disable()<CR>", "Hide diagnostics" }
lvim.builtin.which_key.mappings["ce"] = { "<cmd>lua vim.diagnostic.enable()<CR>", "Show diagnostics" }
lvim.builtin.which_key.mappings["ch"] = { "<cmd>nohlsearch<CR>", "Clear highlight search" }
lvim.builtin.which_key.mappings["gg"] = { ":LazyGit<CR>", "LazyGit" }
lvim.builtin.which_key.mappings["gp"] = { ":Git push origin HEAD:refs/for/master<CR>", "Gerrit push" }
lvim.builtin.which_key.mappings["gP"] = { ":Git push<CR>", "Regular push" }
lvim.builtin.which_key.mappings["zl"] = { ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>", "Clear highlight search" }
lvim.builtin.which_key.mappings["zn"] = { ":%s/\\\\n/\\r/g", "Fix literal linebreaks" }
lvim.builtin.which_key.mappings["zp"] = { ":profile start nvim-profile.log | profile func * | profile file *", "Start profiling" }

lvim.builtin.which_key.mappings["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" }
lvim.builtin.which_key.mappings["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" }
lvim.builtin.which_key.mappings[","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" }
lvim.builtin.which_key.mappings["-"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" }

lvim.builtin.which_key.mappings["gy"] = "Link"
lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
  O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
  l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
  u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
  x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
}
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
  f = {
    ':lua require("telescope.builtin").find_files({cwd = "~/repos/", path_display={"truncate", shorten = {len = 3, exclude = {1,-1}}}})<CR>',
    "Find files",
  },
  y = { ':lua require("user.telescope").yaml_find()<CR>', "Find yaml" },
  t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  w = { "<cmd>Telescope grep_string<cr>", "Find String" },
  s = { ':lua require("user.telescope").spell_check()<CR>', "Spell check" },
  h = { "<cmd>Telescope help_tags<cr>", "Help" },
  H = { "<cmd>Telescope highlights<cr>", "Highlights" },
  l = { "<cmd>Telescope resume<cr>", "Last Search" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  n = { ':lua require("telescope.builtin").git_files()<CR>', "Find in tracked files" },
  N = {
    ':lua require("telescope.builtin").git_files({git_command={"git","ls-files","--modified","--exclude-standard"}})<CR>',
    "Find unstaged files",
  },
  r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
  R = { ':lua require("user.telescope").repo_fd()<CR>', "Find in repos" },
  G = { ':lua require("user.telescope").repo_grep()<CR>', "Grep in repos" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
}
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = { "<cmd>GitBlameToggle<cr>", "Blame" },
  h = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  u = {
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    "Undo Stage Hunk",
  },
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  d = {
    "<cmd>Gitsigns diffthis HEAD<cr>",
    "Diff",
  },
}
lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
  f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
  i = { "<cmd>LspInfo<cr>", "Info" },
  h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
  H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
  I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
  j = {
    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
    "Next Diagnostic",
  },
  k = {
    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
    "Prev Diagnostic",
  },
  d = { ":Telescope diagnostics<CR>", "Find diagnostics" },
  v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
  l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
  q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
  s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols",
  },
  t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
}

lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["L"] = nil
lvim.builtin.which_key.mappings["s"] = nil
lvim.builtin.which_key.mappings["w"] = nil
