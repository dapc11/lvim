local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
lvim.lsp.null_ls.setup = {
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
  log = { enabled = true, level = "trace" },
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.trail_space.with({
      filetypes = {
        "lua",
        "go",
        "python",
        "java",
        "markdown",
        "sh",
      },
    }),
    null_ls.builtins.formatting.stylua.with({ extra_args = { "--search-parent-directories" } }),
    null_ls.builtins.diagnostics.golangci_lint.with({ prefer_local = true }),
    null_ls.builtins.formatting.goimports.with({ prefer_local = true }),
    null_ls.builtins.formatting.gofmt.with({ prefer_local = true }),
    null_ls.builtins.formatting.black.with({ prefer_local = true }),
    null_ls.builtins.formatting.isort.with({ prefer_local = true, extra_args = { "--profile", "black" } }),
    null_ls.builtins.diagnostics.pylint.with({
      prefer_local = true,
      extra_args = {
        "--disable=R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309,C0103,W0201,E0401",
      },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    null_ls.builtins.diagnostics.flake8.with({
      prefer_local = true,
      extra_args = {
        "--extend-ignore=E302,E501,D107,D105,W503,E203,D100,D103,F401",
      },
    }),
  },
}
