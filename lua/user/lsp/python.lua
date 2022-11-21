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
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("n", "gf", "<cmd>PytrizeJumpFixture<Cr>", "Jump To Fixture")
    map("n", "<leader>Dm", "<cmd>lua require('dap-python').test_method()<cr>", "Test Method")
    map("n", "<leader>Df", "<cmd>lua require('dap-python').test_class()<cr>", "Test Class")
    map("n", "<leader>Ds", "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection")
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
