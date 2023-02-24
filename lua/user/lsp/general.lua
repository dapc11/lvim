lvim.lsp.diagnostics.virtual_text = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls", "gopls", "yamlls" })
lvim.lsp.installer.setup.ensure_installed = {
  "pyright",
  "lua_ls",
  "jsonls",
}
