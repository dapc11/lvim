vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = vim.api.nvim_create_augroup("GoFormat", {}),
})

return {
  disable_defaults = false,
  go = "go",
  gofmt = "gofmt",
  max_line_len = 100,
  comment_placeholder = "",
  icons = { breakpoint = "", currentpos = "" },
  lsp_cfg = {
    settings = {
      gopls = {
        gofumpt = false,
        codelenses = {
          gc_details = true,
          generate = true,
          regenerate_cgo = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
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
        symbolMatcher = "fuzzy",
        completeUnimported = true,
        staticcheck = false,
        matcher = "Fuzzy",
        usePlaceholders = true,
        analyses = {
          fieldalignment = true,
          nilness = true,
          shadow = true,
          unusedparams = true,
          unusedwrite = true,
        },
      },
    },
  },
  lsp_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  lsp_keymaps = false,
  sign_priority = 5,
  test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
  luasnip = true,
}
