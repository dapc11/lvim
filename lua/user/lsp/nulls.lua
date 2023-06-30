local lspconfig = require("lspconfig")
local nls = require("null-ls")

sources = {
  nls.builtins.code_actions.gitsigns,
  nls.builtins.diagnostics.trail_space.with({
    filetypes = {
      "lua",
      "go",
      "python",
      "java",
      "markdown",
      "sh",
    },
  }),
  -- Lua
  nls.builtins.formatting.stylua,
  -- Python
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort.with({ extra_args = { "--profile", "black" } }),
  nls.builtins.diagnostics.pylint.with({
    extra_args = {
      "--disable=R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309,C0103,W0201,E0401",
    },
    diagnostics_postprocess = function(diagnostic)
      diagnostic.code = diagnostic.message_id
    end,
  }),
  nls.builtins.diagnostics.flake8.with({
    extra_args = {
      "--extend-ignore=E302,E501,D107,D105,W503,E203,D100,D103,F401",
    },
  }),
}

-- Go
local status_ok, go = pcall(require, "go.null_ls")
if status_ok then
  table.insert(sources, go.gotest())
  table.insert(sources, go.gotest_action())
  table.insert(sources, go.golangci_lint())
end

lvim.lsp.null_ls.setup = {
  root_dir = require("null-ls.utils").root_pattern(".git"),
  should_attach = function(bufnr)
    return not vim.api.nvim_buf_get_name(bufnr):match("^diffview://")
  end,
  sources = sources,
  debounce = 1000,
  default_timeout = 5000,
}
