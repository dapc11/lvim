lvim.lsp.diagnostics.virtual_text = {
  source = "always",
  severity = vim.diagnostic.severity.ERROR,
  spacing = 1,
}

lvim.lsp.installer.setup.ensure_installed = {
  "sumeko_lua",
  "jsonls",
  "pyright",
  "gopls",
}

lvim.format_on_save = {
  pattern = { "*.lua", "*.py", "*.go" },
}

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
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

--- Golang
local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup({
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
})
local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup({
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
})

local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

lvim.builtin.which_key.mappings["dT"] = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" }
--- /Golang
