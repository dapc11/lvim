local lsp_manager = require("lvim.lsp.manager")
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
        diagnosticSeverityOverrides = {
            reportOptionalMemberAccess = "none",
            reportMissingImports = "none",
        },
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
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
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end
    which_key.register({ D = "which_key_ignore", L = "which_key_ignore" })
    which_key.register(mappings, opts)
  end,
}

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
