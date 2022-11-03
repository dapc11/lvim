local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

local go_opts = {
  settings = {
    gopls = {
      gofumpt = false, -- A stricter gofmt
      codelenses = {
        gc_details = true, -- Toggle the calculation of gc annotations
        generate = true, -- Runs go generate for a given directory
        regenerate_cgo = true, -- Regenerates cgo definitions
        test = true,
        tidy = true, -- Runs go mod tidy for a module
        upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
        vendor = true, -- Runs go mod vendor for a module
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      diagnosticsDelay = "300ms",
      experimentalWatchedFileDelay = "100ms",
      symbolMatcher = "fuzzy",
      completeUnimported = true,
      staticcheck = true,
      matcher = "Fuzzy",
      usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
      analyses = {
        fieldalignment = true, -- find structs that would use less memory if their fields were sorted
        nilness = true, -- check for redundant or impossible nil comparisons
        shadow = true, -- check for possible unintended shadowing of variables
        unusedparams = true, -- check for unused parameters of functions
        unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
      },
    },
  },
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
    map("<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
    map("<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
    map("<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
    map("<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
  end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.go" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

lsp_manager.setup("gopls", go_opts)

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
--- /Golang