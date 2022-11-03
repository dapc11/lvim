local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" }, extra_args = { "--profile", "black" } },
  { command = "stylua", filetypes = { "lua" } },
  { command = "gofmt", filetypes = { "go" } },
  { command = "goimports", filetypes = { "go" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    command = "pylint",
    filetypes = { "python" },
    extra_args = {
      "-d",
      "R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309,C0103,W0201,C0330,C0326",
    },
  },
  {
    command = "flake8",
    filetypes = { "python" },
    extra_args = {
      "--extend-ignore=E302,E501,D107,D105,W503,E203,D100,D103",
    },
  },
})
local null_ls = require("null-ls")
lvim.lsp.null_ls.setup = { sources = {
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.diagnostics.trail_space,
} }
