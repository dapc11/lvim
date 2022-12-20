lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true

lvim.builtin.which_key.mappings["P"] = { require("telescope.builtin").projects, "Projects" }
lvim.builtin.which_key.mappings["o"] = { require("telescope.builtin").find_files, "Find files" }
lvim.builtin.which_key.mappings["<leader>"] = {
  function()
    require("telescope.builtin").live_grep({
      path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
    })
  end,
  "Live grep in current repo",
}

lvim.builtin.which_key.mappings["b"] = { require("telescope.builtin").buffers, "Buffers" }
lvim.builtin.which_key.mappings["v"] = { "<cmd>vsplit<cr>", "vsplit" }
lvim.builtin.which_key.mappings["h"] = { require("telescope.builtin").oldfiles, "Recent files" }
lvim.builtin.which_key.mappings["n"] = {
  require("telescope.builtin").git_files,
  "Find in tracked files",
}
lvim.builtin.which_key.mappings["N"] = {
  function()
    require("telescope.builtin").git_files({ git_command = { "git", "ls-files", "--modified", "--exclude-standard" } })
  end,
  "Find in unstaged files",
}
lvim.builtin.which_key.mappings["q"] = {
  require("user.functions").smart_quit,
  "Quit",
}
lvim.builtin.which_key.mappings["w"] = { "<cmd>bdelete!<CR>", "Close current buffer" }
lvim.builtin.which_key.mappings["/"] = {
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  "Comment",
}

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
lvim.builtin.which_key.mappings["gg"] = { "<cmd>LazyGit<CR>", "LazyGit" }
lvim.builtin.which_key.mappings["gp"] = { "<cmd>Git push origin HEAD:refs/for/master<CR>", "Gerrit push" }
lvim.builtin.which_key.mappings["gP"] = { "<cmd>Git push<CR>", "Regular push" }
vim.cmd([[
    function! ClearQuickfixList()
        call setqflist([])
        cclose
    endfunction
    command! ClearQuickfixList call ClearQuickfixList()
]])
lvim.builtin.which_key.mappings["pS"] = { "<cmd>LvimSyncCorePlugins<CR>", "Sync Core Plugins" }
lvim.builtin.which_key.mappings["xx"] = { "<cmd>ClearQuickfixList<CR>", "Clear qf" }
lvim.builtin.which_key.mappings["xl"] = {
  ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
  "Clear highlight search",
}
lvim.builtin.which_key.mappings["xn"] = { ":%s/\\\\n/\\r/g", "Fix literal linebreaks" }
lvim.builtin.which_key.mappings["xp"] = {
  ":profile start nvim-profile.log | profile func * | profile file *",
  "Start profiling",
}

lvim.builtin.which_key.mappings["m"] = {
  require("harpoon.mark").add_file,
  "Harpoon",
}
lvim.builtin.which_key.mappings["."] = {
  require("harpoon.ui").nav_next,
  "Harpoon Next",
}
lvim.builtin.which_key.mappings[","] = {
  require("harpoon.ui").nav_prev,
  "Harpoon Prev",
}
lvim.builtin.which_key.mappings["-"] = {
  require("harpoon.ui").toggle_quick_menu,
  "Harpoon UI",
}

lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { require("telescope.builtin").buffers, "Find buffer" },
  f = {
    function()
      require("telescope.builtin").find_files({
        cwd = "~/repos/",
        path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
      })
    end,
    "Find files",
  },
  t = { require("telescope.builtin").live_grep, "Find Text" },
  w = { require("telescope.builtin").grep_string, "Find String" },
  s = {
    require("user.telescopefinders").spell_check,
    "Spell check",
  },
  h = { require("telescope.builtin").help_tags, "Help" },
  H = { require("telescope.builtin").highlights, "Highlights" },
  l = { require("telescope.builtin").resume, "Last Search" },
  M = { require("telescope.builtin").man_pages, "Man Pages" },
  n = {
    require("telescope.builtin").git_files,
    "Find in tracked files",
  },
  N = {
    function()
      require("telescope.builtin").git_files({
        git_command = { "git", "ls-files", "--modified", "--exclude-standard" },
      })
    end,
    "Find unstaged files",
  },
  r = { require("telescope.builtin").oldfiles, "Recent File" },
  R = {
    require("user.telescopefinders").repo_fd,
    "Find in repos",
  },
  G = {
    require("user.telescopefinders").repo_grep,
    "Grep in repos",
  },
  k = { require("telescope.builtin").keymaps, "Keymaps" },
  C = { require("telescope.builtin").commands, "Commands" },
}
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  L = {
    '<cmd>Git log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative<cr>',
    "Log",
  },
  R = {
    function()
      require("gitsigns").reset_buffer()
    end,
    "Reset Buffer",
  },
  b = { "<cmd>Git blame --date=human --color-by-age --abbrev-commit<cr>", "Blame" },
  cb = { require("telescope.builtin").git_branches, "Checkout branch" },
  cc = { require("telescope.builtin").git_commits, "Checkout commit" },
  d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
  h = {
    require("gitsigns").preview_hunk,
    "Preview Hunk",
  },
  j = {
    require("gitsigns").next_hunk,
    "Next Hunk",
  },
  k = {
    require("gitsigns").prev_hunk,
    "Prev Hunk",
  },
  l = {
    '<cmd>Git log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all<cr>',
    "Log",
  },
  s = { require("telescope.builtin").git_status, "Open changed file" },
  p = { "<cmd>Git pull --rebase<cr>", "Pull & rebase" },
  u = { "<cmd>Git submodule update --init --recursive<cr>", "Update Submodules" },
  r = { require("gitsigns").reset_hunk, "Reset Hunk" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  c = {
    function()
      require("neotest").run.run()
    end,
    "Run nearest test",
  },
  f = {
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    "Run current file",
  },
  d = {
    function()
      require("neotest").run.run({ strategy = "dap" })
    end,
    "Debug nearest test",
  },
  l = {
    function()
      require("neotest").run.run_last()
    end,
    "Re-run last",
  },
  s = {
    function()
      require("neotest").summary.toggle()
    end,
    "Toggle test summary",
  },
  O = {
    function()
      require("neotest").output.open({ enter = true })
    end,
    "Open test output",
  },
  o = {
    function()
      require("neotest").output_panel.open()
    end,
    "Open test output panel",
  },
  j = {
    function()
      require("neotest").jump.next({ status = "failed" })
    end,
    "Next Failed Test",
  },
  k = {
    function()
      require("neotest").jump.prev({ status = "failed" })
    end,
    "Prev Failed Test",
  },
}

lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = {
    vim.lsp.buf.code_action,
    "Code Action",
  },
  f = {
    function()
      vim.lsp.buf.format({ async = true })
    end,
    "Format",
  },
  F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
  i = { "<cmd>LspInfo<cr>", "Info" },
  H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
  I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
  j = {
    function()
      vim.diagnostic.goto_next({ buffer = 0 })
    end,
    "Next Diagnostic",
  },
  k = {
    function()
      vim.diagnostic.goto_prev({ buffer = 0 })
    end,
    "Prev Diagnostic",
  },
  d = {
    function()
      require("telescope.builtin").diagnostics({ bufnr = 0 })
    end,
    "Find diagnostics",
  },
  v = {
    function()
      require("lsp_lines").toggle()
    end,
    "Virtual Text",
  },
  l = {
    vim.lsp.codelens.run,
    "CodeLens Action",
  },
  q = {
    vim.lsp.diagnostic.set_loclist,
    "Quickfix",
  },
  r = {
    vim.lsp.buf.rename,
    "Rename",
  },
  s = { require("telescope.builtin").lsp_document_symbols, "Document Symbols" },
  S = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols" },
  t = {
    require("user.functions").toggle_diagnostics,
    "Toggle Diagnostics",
  },
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
