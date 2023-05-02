local bufnr = vim.api.nvim_get_current_buf()
local map = require("user.functions").map
map("n", "gf", "<cmd>PytrizeJumpFixture<Cr>", "Jump To Fixture", bufnr)

lvim.builtin.which_key.mappings["lv"] = {
  function()
    require("swenv.api").pick_venv()
  end,
  "Pick Venv",
  buffer = bufnr
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
