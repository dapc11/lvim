lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["o"] = { "<cmd>Telescope find_files<CR>", "Find files" }
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
lvim.builtin.which_key.mappings["w"] = { ":bdelete!<CR>", "Close current buffer" }
lvim.builtin.which_key.mappings["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" }

vim.g.diagnostics_visible = true
lvim.builtin.which_key.mappings["ct"] = {
  function()
    if vim.g.diagnostics_visible then
      vim.g.diagnostics_visible = false
      vim.diagnostic.disable()
    else
      vim.g.diagnostics_visible = true
      vim.diagnostic.enable()
    end
  end,
  "Toggle diagnostics",
}
lvim.builtin.which_key.mappings["cl"] = {
  function()
    local config = lvim.lsp.diagnostics.float
    config.scope = "line"
    config.severity_sort = true
    vim.diagnostic.open_float(0, config)
  end,
  "Show line diagnostics",
}
lvim.builtin.which_key.mappings["gg"] = { ":LazyGit<CR>", "LazyGit" }
lvim.builtin.which_key.mappings["gp"] = { ":Git push origin HEAD:refs/for/master<CR>", "Gerrit push" }
lvim.builtin.which_key.mappings["gP"] = { ":Git push<CR>", "Regular push" }
vim.cmd([[
    function! ClearQuickfixList()
        call setqflist([])
        cclose
    endfunction
    command! ClearQuickfixList call ClearQuickfixList()
]])
lvim.builtin.which_key.mappings["pS"] = { ":LvimSyncCorePlugins<CR>", "Sync Core Plugins" }
lvim.builtin.which_key.mappings["xx"] = { ":ClearQuickfixList<CR>", "Clear qf" }
lvim.builtin.which_key.mappings["xl"] = {
  ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
  "Clear highlight search",
}
lvim.builtin.which_key.mappings["xn"] = { ":%s/\\\\n/\\r/g", "Fix literal linebreaks" }
lvim.builtin.which_key.mappings["xp"] = {
  ":profile start nvim-profile.log | profile func * | profile file *",
  "Start profiling",
}

lvim.builtin.which_key.mappings["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" }
lvim.builtin.which_key.mappings["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" }
lvim.builtin.which_key.mappings[","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" }
lvim.builtin.which_key.mappings["-"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" }

lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
  f = {
    ':lua require("telescope.builtin").find_files({cwd = "~/repos/", path_display={"truncate", shorten = {len = 3, exclude = {1,-1}}}})<CR>',
    "Find files",
  },
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
  L = {
    '<cmd>Git log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative<cr>',
    "Log",
  },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  b = { "<cmd>Git blame --date=human --color-by-age --abbrev-commit<cr>", "Blame" },
  cb = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  cc = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
  h = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = {
    '<cmd>Git log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all<cr>',
    "Log",
  },
  s = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  p = { "<cmd>Git pull --rebase<cr>", "Pull & rebase" },
  u = { "<cmd>Git submodule update --init --recursive<cr>", "Update Submodules" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  c = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
  f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run current file" },
  d = { '<cmd>lua require("neotest").run.run({ strategy = "dap" })<CR>', "Debug nearest test" },
  l = { '<cmd>lua require("neotest").run.run_last()<CR>', "Re-run last" },
  s = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle test summary" },
  O = { '<cmd>lua require("neotest").output.open({ enter = true })<CR>', "Open test output" },
  o = { '<cmd>lua require("neotest").output_panel.open()<CR>', "Open test output panel" },
  j = {
    "<cmd>lua require('neotest').jump.next({ status = 'failed' })",
    "Next Failed Test",
  },
  k = {
    "<cmd>lua require('neotest').jump.prev({ status = 'failed' })",
    "Prev Failed Test",
  },
}

lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
  i = { "<cmd>LspInfo<cr>", "Info" },
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
  d = { "<cmd> lua require 'telescope.builtin'.diagnostics({bufnr=0})<CR>", "Find diagnostics" },
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
lvim.builtin.which_key.mappings["z"] = {
  name = "Zettelkasten",
  n = { "<cmd>ZkNew<cr>", "New note" },
  b = { "<cmd>ZkBrowse<cr>", "Browse notes" },
  z = { "<cmd>Telescope live_grep cwd=~/notes<cr>", "Find notes" },
}

lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["L"] = nil
lvim.builtin.which_key.mappings["s"] = nil
