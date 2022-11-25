lvim.lsp.diagnostics.virtual_text = {
  source = "always",
  severity = vim.diagnostic.severity.ERROR,
  spacing = 1,
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls", "gopls", "yamlls" })
lvim.lsp.installer.setup.ensure_installed = {
  "pyright",
  "sumneko_lua",
  "jsonls",
}

-- lvim.format_on_save = {
--   pattern = { "*.lua", "*.py", "*.go" },
-- }
lvim.format_on_save = false

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" }, extra_args = { "--profile", "black" } },
  { command = "stylua", filetypes = { "lua" } },
  { command = "gofmt", filetypes = { "go" } },
  { command = "goimports", filetypes = { "go" } },
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    command = "pylint",
    filetypes = { "python" },
    extra_args = {
      "-d",
      "R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309",
    },
  },
  {
    command = "flake8",
    filetypes = { "python" },
    extra_args = {
      "--per-file-ignores=**/test_*:D100,D103",
    },
  },
})
local null_ls = require("null-ls")
lvim.lsp.null_ls.setup = {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.trail_space,
  },
}
