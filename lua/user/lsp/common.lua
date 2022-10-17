vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls", "pyright", "gopls", "yamlls" })
lvim.lsp.diagnostics.virtual_text = {
  source = "always",
  severity = vim.diagnostic.severity.ERROR,
  spacing = 1,
}

lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
}

-- lvim.format_on_save = {
--   pattern = { "*.lua", "*.py", "*.go" },
-- }
lvim.format_on_save = false
