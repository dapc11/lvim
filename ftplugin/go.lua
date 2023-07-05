local bufnr = vim.api.nvim_get_current_buf()

require("which-key").register({
  ["<leader>c"] = { name = "+Go", buffer = bufnr },
  ["<leader>ci"] = { vim.cmd.GoInstallDeps, "Install Go Dependencies", buffer = bufnr },
  ["<leader>ct"] = {
    function()
      vim.cmd.GoMod("tidy")
    end,
    "Tidy",
    buffer = bufnr,
  },
  ["<leader>cg"] = { vim.cmd.GoGenerate, "Go Generate", buffer = bufnr },
  ["<leader>cf"] = {
    function()
      vim.cmd.GoGenerate("%")
    end,
    "Go Generate File",
    buffer = bufnr,
  },
  ["<leader>cc"] = { vim.cmd.GoCmt, "Generate Comment", buffer = bufnr },
  ["<leader>cb"] = { vim.cmd.GoBuild, "Build", buffer = bufnr },
  ["<leader>ce"] = { vim.cmd.GoGenReturn, "Generate Return", buffer = bufnr },
  ["<leader>tt"] = { vim.cmd.GoTest, "Run Tests", buffer = bufnr },
  ["<leader>ta"] = { vim.cmd.GoAddTest, "Add Test", buffer = bufnr },
  ["<leader>tA"] = { vim.cmd.GoAddAllTest, "Add All Missing Tests", buffer = bufnr },
  ["<leader>tF"] = { vim.cmd.GoTestFile, "Test File", buffer = bufnr },
  ["<leader>tf"] = { vim.cmd.GoTestFunc, "Test Func", buffer = bufnr },
  ["<leader>tp"] = { vim.cmd.GoTestPkg, "Test Package", buffer = bufnr },
})
