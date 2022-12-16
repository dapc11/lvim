
-- lvim.lsp.diagnostics.virtual_text = {
--   source = "always",
--   severity = vim.diagnostic.severity.ERROR,
--   spacing = 1,
-- }
lvim.lsp.diagnostics.virtual_text = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls", "gopls", "yamlls" })
lvim.lsp.installer.setup.ensure_installed = {
  "pyright",
  "sumneko_lua",
  "jsonls",
}
