local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  ["<leader>C"] = { name = "+Json" },
  ["<leader>Cf"] = {
    ":%!jq '.'",
    "Format",
    mode = { "v", "n" },
    buffer = bufnr,
  },
})

local json_opts = {
  settings = {
    json = {
      schemas = vim.list_extend({
        {
          description = "pyright config",
          fileMatch = { "pyrightconfig.json" },
          name = "pyrightconfig.json",
          url = "https://raw.githubusercontent.com/microsoft/pyright/main/packages/vscode-pyright/schemas/pyrightconfig.schema.json",
        },
      }, require("schemastore").json.schemas({})),
    },
  },
}

require("lvim.lsp.manager").setup("jsonls", json_opts)
