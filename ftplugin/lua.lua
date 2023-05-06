local opts = {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        enable = false,
        globals = { "vim", "lvim", "reload" },
      },
    },
  },
}
require("lvim.lsp.manager").setup("lua_ls", opts)
