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

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" }, extra_args = { "--profile", "black" } },
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
local null_ls = require("null-ls")
lvim.lsp.null_ls.setup = {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.trail_space,
  },
}
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("Couldn't import which-key")
  return
end

--- Python
local python_opts = {
  root_dir = function(fname)
    local util = require("lspconfig.util")
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "manage.py",
      "pyrightconfig.json",
    }
    return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(".git")(fname) or util.path.dirname(fname)
  end,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }
    local mappings = {
      D = {
        name = "Python Debug",
        m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" },
        f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
        s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
      },
    }
    which_key.register(mappings, opts)
  end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("pyright", python_opts)

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function()
  require("dap-python").test_runner = "pytest"
end)

--- /Python
