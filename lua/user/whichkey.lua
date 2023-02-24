vim.g.diagnostics_visible = true

lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.ignore_missing = true
lvim.builtin.which_key.setup.icons.group = " "

lvim.builtin.which_key.mappings["m"] = { require("harpoon.mark").add_file, "Harpoon Add" }
lvim.builtin.which_key.mappings["."] = { require("harpoon.ui").nav_next, "Harpoon Next" }
lvim.builtin.which_key.mappings[","] = { require("harpoon.ui").nav_prev, "Harpoon Prev" }
lvim.keys.normal_mode["<C-e>"] = require("harpoon.ui").toggle_quick_menu

lvim.builtin.which_key.mappings["P"] = { require("telescope").extensions.projects.projects, "Projects" }
lvim.builtin.which_key.mappings["o"] = { require("telescope.builtin").find_files, "Find files" }
lvim.builtin.which_key.mappings["<leader>"] = {
  function()
    require("telescope.builtin").live_grep({
      path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
    })
  end,
  "Live Grep",
}

lvim.builtin.which_key.mappings["b"] = { require("telescope.builtin").buffers, "Buffers" }
lvim.builtin.which_key.mappings["v"] = { vim.cmd.vsplit, "Split Vertically" }
lvim.builtin.which_key.mappings["s"] = { vim.cmd.split, "Split Horizontally" }
lvim.builtin.which_key.mappings["h"] = { require("telescope.builtin").oldfiles, "Recent files" }
lvim.builtin.which_key.mappings["n"] = { require("telescope.builtin").git_files, "Find in tracked files" }
lvim.builtin.which_key.mappings["N"] = {
  function()
    require("telescope.builtin").git_files({
      git_command = { "git", "ls-files", "--modified", "--exclude-standard" },
    })
  end,
  "Find in unstaged files",
}
lvim.builtin.which_key.mappings["q"] = { require("user.functions").smart_quit, "Quit" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>bdelete!<CR>", "Close Current Buffer" }
lvim.builtin.which_key.mappings["/"] = { require("Comment.api").toggle.linewise.current, "Comment" }

vim.cmd([[
    function! ClearQuickfixList()
        call setqflist([])
        cclose
    endfunction
    command! ClearQuickfixList call ClearQuickfixList()
]])
lvim.builtin.which_key.mappings["ps"] = {
  function()
    vim.cmd.Lazy("sync")
  end,
  "Sync Core Plugins",
}
lvim.builtin.which_key.mappings["pS"] = { vim.cmd.LvimSyncCorePlugins, "Sync Core Plugins" }

lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { require("telescope.builtin").buffers, "Buffer" },
  d = {
    function()
      require("telescope.builtin").find_files({
        cwd = "~/",
        path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
      })
    end,
    "File",
  },
  f = {
    function()
      require("telescope.builtin").find_files({
        cwd = "~/repos/",
        path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
      })
    end,
    "File",
  },
  t = { require("telescope.builtin").live_grep, "Live Grep" },
  w = { require("telescope.builtin").grep_string, "String" },
  s = { require("user.telescopefinders").spell_check, "Spelling" },
  l = { require("telescope.builtin").resume, "Last Search" },
  n = { require("telescope.builtin").git_files, "Tracked File" },
  p = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Tmux Session" },
  N = {
    function()
      require("telescope.builtin").git_files({
        git_command = { "git", "ls-files", "--modified", "--exclude-standard" },
      })
    end,
    "Unstaged File",
  },
  r = { require("telescope.builtin").oldfiles, "Recent File" },
  R = { require("user.telescopefinders").repo_fd, "File in Repos" },
  G = { require("user.telescopefinders").repo_grep, "String in Repos" },
  k = { require("telescope.builtin").keymaps, "Keymap" },
  C = { require("telescope.builtin").commands, "Command" },
}

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  g = { "<cmd>tab Git<CR>", "Status" },
  p = {
    name = "Push",
    p = {
      function()
        vim.cmd.Git("push", "origin", "HEAD:refs/for/master")
      end,
      "Gerrit",
    },
    P = {
      function()
        vim.cmd.Git("push")
      end,
      "Regular",
    },
  },
  L = {
    '<cmd>tab Git log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative<cr>',
    "Log",
  },
  b = {
    function()
      vim.cmd.Git("blame", "--date=human", "--color-by-age", "--abbrev-commit")
    end,
    "Blame",
  },
  c = {
    name = "Checkout",
    b = { require("telescope.builtin").git_branches, "Checkout branch" },
    c = { require("telescope.builtin").git_commits, "Checkout commit" },
  },
  d = {
    function()
      vim.cmd.Git("diff")
    end,
    "Diff",
  },
  D = { "<cmd>Gvdiffsplit!<CR>", "Diff-3-way" },
  h = { require("gitsigns").preview_hunk, "Preview Hunk" },
  l = {
    '<cmd>tab Git log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all<cr>',
    "Log",
  },
  s = { require("gitsigns").stage_hunk, "Stage Hunk" },
  u = { require("gitsigns").undo_stage_hunk, "Unstage Hunk" },
  P = {
    function()
      vim.cmd.Git("pull", "--rebase")
    end,
    "Pull & rebase",
  },
  U = {
    function()
      vim.cmd.Git("submodule", "update", "--init", "--recursive")
    end,
    "Update Submodules",
  },
  r = { require("gitsigns").reset_hunk, "Reset Hunk" },
  R = {
    function()
      require("gitsigns").reset_buffer()
    end,
    "Reset Buffer",
  },
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
    name = "Actions",
    a = { vim.lsp.buf.code_action, "Code" },
    l = { vim.lsp.codelens.run, "Lens" },
  },
  f = {
    function()
      vim.lsp.buf.format({ async = true })
    end,
    "Format",
  },
  F = { vim.cmd.LspToggleAutoFormat, "Toggle Autoformat" },
  H = { vim.cmd.IlluminationToggle, "Toggle Doc HL" },
  g = { vim.cmd.Neogen, "Generate Annotation" },
  t = {
    function()
      if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
      else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
      end
    end,
    "Toggle Diagnostics",
  },
  l = {
    function()
      local config = lvim.lsp.diagnostics.float
      config.scope = "line"
      config.severity_sort = true
      vim.diagnostic.open_float(0, config)
    end,
    "Show Line Diagnostics",
  },
  d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Toggle Diagnostics List" },
  q = { "<cmd>TroubleToggle quickfix<CR>", "Toggle Quickfix List" },
  r = { vim.lsp.buf.rename, "Rename" },
  s = { require("telescope.builtin").lsp_document_symbols, "Document Symbols" },
  S = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols" },
}

lvim.builtin.which_key.mappings["z"] = {
  name = "Zettelkasten",
  n = { "<cmd>ZkNew<cr>", "New Note" },
  b = { "<cmd>ZkBrowse<cr>", "Browse Notes" },
  z = { "<cmd>Telescope live_grep cwd=~/notes<cr>", "Find Notes" },
}

local dap = require("dap")
local dapui = require("dapui")
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { dap.toggle_breakpoint, "Breakpoint" },
  c = { dap.continue, "Continue" },
  i = {
    function()
      dap.step_into("Into")
    end,
    "Step Into",
  },
  o = { dap.step_over, "Over" },
  O = { dap.step_out, "Out" },
  r = { dap.repl.toggle, "Repl" },
  l = { dap.run_last, "Last" },
  u = { dapui.toggle, "UI" },
  x = { dap.terminate, "Exit" },
}

lvim.builtin.which_key.mappings["x"] = {
  name = "Misc",
  x = {
    function()
      vim.cmd.ToggleTerm("direction=tab")
    end,
    "Toggle Terminal",
  },
  v = {
    function()
      vim.cmd.ToggleTerm("direction=vertical", "size=80")
    end,
    "Toggle Vertical Terminal",
  },
  s = {
    function()
      vim.cmd.ToggleTerm("direction=horizontal")
    end,
    "Toggle Horizontal Terminal",
  },
  c = { vim.cmd.ClearQuickfixList, "Clear QF" },
  l = {
    ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
    "Clear Highlight Search",
  },
  n = { ":%s/\\\\n/\\r/g", "Fix Literal Linebreaks" },
  p = {
    ":profile start nvim-profile.log | profile func * | profile file *",
    "Start Profiling",
  },
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

lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["L"] = nil
