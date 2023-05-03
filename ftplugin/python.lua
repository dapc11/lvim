-- pip install virtualenvwrapper
-- ..
-- export WORKON_HOME=~/envs
-- mkdir -p $WORKON_HOME
-- find / -name virtualenvwrapper.sh
-- # add to zshrc
-- source /usr/local/bin/virtualenvwrapper.sh
-- mkvirtualenv env1
--
--
-- # add to venv specific pythonpath
-- add2virtualenv <dir>

local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "gf", "<cmd>PytrizeJumpFixture<Cr>", "Jump To Fixture", bufnr)

lvim.builtin.which_key.mappings["lv"] = {
  function()
    require("swenv.api").pick_venv()
  end,
  "Pick Venv",
  buffer = bufnr,
}

-- pcall(function()
--   require("dap-python").test_runner = "pytest"
--   local dap = require("dap")
--   dap.adapters.python = {
--     type = "executable",
--     command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
--     args = { "-m", "debugpy.adapter" },
--   }
--   dap.configurations.python = {
--     {
--       type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
--       request = "launch",
--       name = "Launch file",
--       program = "${file}", -- This configuration will launch the current file if used.
--       pythonPath = "python3",
--     },
--   }
--   require("neotest").setup({
--     adapters = {
--       require("neotest-python")({
--         dap = { justMyCode = false },
--         args = { "--log-level", "DEBUG" },
--         runner = "pytest",
--         python = os.getenv("VIRTUAL_ENV") .. "/bin/python",
--       }),
--     },
--   })
-- end)

local opts = {
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
          reportMissingImports = "none",
          reportOptionalMemberAccess = "none",
        },
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly", -- or workspace
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
}
local function match(dir, pattern)
  if string.sub(pattern, 1, 1) == "=" then
    return vim.fn.fnamemodify(dir, ":t") == string.sub(pattern, 2, #pattern)
  else
    return vim.fn.globpath(dir, pattern) ~= ""
  end
end

local function parent_dir(dir)
  return vim.fn.fnamemodify(dir, ":h")
end

local function get_root(pythonpath_file)
  local current = vim.api.nvim_buf_get_name(0)
  local parent = parent_dir(current)

  while 1 do
    if match(parent, pythonpath_file) then
      return parent
    end

    current, parent = parent, parent_dir(parent)
    if parent == current then
      break
    end
  end
  return nil
end

local function file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

local pythonpath_file = ".pythonpath"
local root = get_root(pythonpath_file)

if root == nil then
  vim.env.PYTHONPATH = nil
else
  local absolute_path = root .. "/" .. pythonpath_file
  local python_path = ""
  if file_exists(absolute_path) then
    for line in io.open(absolute_path):lines() do
      python_path = python_path .. root .. "/" .. line .. ":"
    end
    vim.env.PYTHONPATH = python_path
  else
    vim.env.PYTHONPATH = nil
  end
end

require("lvim.lsp.manager").setup("pyright", opts)
