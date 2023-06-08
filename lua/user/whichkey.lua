vim.g.diagnostics_visible = true

lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.ignore_missing = true
lvim.builtin.which_key.setup.icons.group = " "

local tb = require("telescope.builtin")
local te = require("telescope").extensions

lvim.builtin.which_key.mappings["P"] = { te.projects.projects, "Projects" }
lvim.builtin.which_key.mappings["o"] = { tb.find_files, "Find files" }
lvim.builtin.which_key.mappings["<leader>"] = {
  function()
    tb.live_grep({
      path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
    })
  end,
  "Live Grep",
}

lvim.builtin.which_key.mappings["v"] = { vim.cmd.vsplit, "Split Vertically" }
lvim.builtin.which_key.mappings["s"] = { vim.cmd.split, "Split Horizontally" }
lvim.builtin.which_key.mappings[","] = { tb.buffers, "Buffers" }
lvim.builtin.which_key.mappings["h"] = { tb.oldfiles, "Recent files" }
lvim.builtin.which_key.mappings["n"] = { tb.git_files, "Find in tracked files" }
lvim.builtin.which_key.mappings["N"] = {
  require("user.telescopefinders").git_unstaged,
  "Find in unstaged files",
}
lvim.builtin.which_key.mappings["q"] = { require("user.functions").smart_quit, "Quit" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>bdelete!<CR>", "Close Current Buffer" }
lvim.builtin.which_key.mappings["/"] = { require("Comment.api").toggle.linewise.current, "Comment" }

lvim.builtin.which_key.mappings["bd"] = { "<cmd>bd<cr>", "Close buffer" }
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
  name = "Search",
  d = {
    function()
      tb.find_files({
        cwd = "~/",
        path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
      })
    end,
    "In home dir",
  },
  f = {
    function()
      tb.find_files({
        cwd = "~/repos/",
        path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } },
      })
    end,
    "In repos",
  },
  t = { tb.live_grep, "Live Grep" },
  w = { tb.grep_string, "String" },
  s = { require("user.telescopefinders").spell_check, "Spelling" },
  l = { tb.resume, "Last Search" },
  n = { tb.git_files, "Tracked File" },
  p = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Tmux Session" },
  N = {
    function()
      tb.git_files({
        git_command = { "git", "ls-files", "--modified", "--exclude-standard" },
      })
    end,
    "Unstaged File",
  },
  h = { tb.oldfiles, "Recent File" },
  r = { require("user.telescopefinders").repo_fd, "File in Repos" },
  g = { require("user.telescopefinders").repo_grep, "String in Repos" },
  H = { tb.highlights, "Highlight" },
  k = { tb.keymaps, "Keymap" },
  C = { tb.commands, "Command" },
}

-- Git
lvim.builtin.which_key.mappings["gd"] = {
  name = "Diff",
  c = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
  d = { "<cmd>DiffviewOpen<cr>", "Diffview (all modified files)" },
  D = { "<cmd>Gvdiffsplit!<CR>", "Diff-3-way" },
}
lvim.builtin.which_key.mappings["gh"] = { "<cmd>DiffviewFileHistory %<cr>", "Diffview current file history" }
lvim.builtin.which_key.mappings["gg"] = { "<cmd>tab Git<CR>", "Status" }
lvim.builtin.which_key.mappings["gp"] = {
  name = "Push",
  g = { "<cmd>Git push origin HEAD:refs/for/master<CR>", "Gerrit" },
  p = {
    function()
      vim.cmd.Git("push")
    end,
    "Regular",
  },
}
lvim.builtin.which_key.mappings["gb"] = {
  "<cmd>tab Git blame --date=human --color-by-age --abbrev-commit<CR>",
  "Blame",
}
lvim.builtin.which_key.mappings["gv"] = { require("gitsigns").preview_hunk, "Preview Hunk" }
lvim.builtin.which_key.mappings["gl"] = {
  "<cmd>Gclog %<CR>",
  "Log",
}
lvim.builtin.which_key.mappings["gL"] = {
  '<cmd>tab Git log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all<cr>',
  "Log",
}
lvim.builtin.which_key.mappings["gP"] = {
  "<cmd>Git pull --rebase<CR>",
  "Pull & rebase",
}
lvim.builtin.which_key.mappings["gU"] = {
  function()
    vim.cmd.Git("submodule", "update", "--init", "--recursive<CR>")
  end,
  "Update Submodules",
}

-- Lsp
lvim.builtin.which_key.mappings["lc"] = { "<cmd>LspStop<cr>", "Stop LSP server" }
lvim.builtin.which_key.mappings["lR"] = { "<cmd>LspRestart<cr>", "Restart LSP server" }
lvim.builtin.which_key.mappings["lA"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" }
lvim.builtin.which_key.mappings["lF"] = { vim.cmd.LspToggleAutoFormat, "Toggle Autoformat" }
lvim.builtin.which_key.mappings["lH"] = { vim.cmd.IlluminationToggle, "Toggle Doc HL" }
lvim.builtin.which_key.mappings["ld"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" }
lvim.builtin.which_key.mappings["lD"] = { "<cmd>Telescope diagnostics theme=get_ivy<cr>", "Workspace Diagnostics" }
lvim.builtin.which_key.mappings["ls"] = {
  function()
    tb.lsp_document_symbols({ symbol_width = 80, show_line = false })
  end,
  "Document Symbols",
}
lvim.builtin.which_key.mappings["lS"] = {
  function()
    tb.lsp_dynamic_workspace_symbols({ fname_width = 80, show_line = false })
  end,
  "Workspace Symbols",
}
lvim.builtin.which_key.mappings["ll"] = {
  function()
    local config = lvim.lsp.diagnostics.float
    config.scope = "line"
    config.severity_sort = true
    vim.diagnostic.open_float(0, config)
  end,
  "Show Line Diagnostics",
}
lvim.builtin.which_key.mappings["lt"] = {
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
}

lvim.builtin.which_key.mappings["z"] = {
  name = "Zettelkasten",
  n = { "<Cmd>ZkNew { dir = vim.fn.expand('$HOME/notes'), title = vim.fn.input('Title: ') }<CR>", "New Note" },
  b = { vim.cmd.ZkNotes, "Browse Notes" },
  z = { "<cmd>Telescope live_grep cwd=~/notes<cr>", "Find Notes" },
}

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] = {
  "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP",
}
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
  "Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  "Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


lvim.builtin.which_key.mappings["x"] = {
  name = "Misc",
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
