  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
  D = {
    name = "Go Debug",
    t = { "<cmd>lua require'dap-go'.debug_test()<cr>", "Debug test under cursor" },
    T = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
  },
  L = {
    name = "Go",
    i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
    t = { "<cmd>GoMod tidy<cr>", "Tidy" },
    a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
    A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
    e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
    g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
    f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
    c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
    r = { "<cmd>GoIfErr<Cr>", "Add if err" },
  },
}
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end
which_key.register({D = "which_key_ignore", L = "which_key_ignore"})
which_key.register(mappings, opts)
