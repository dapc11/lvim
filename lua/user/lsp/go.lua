vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = vim.api.nvim_create_augroup("GoFormat", {}),
})

return {
  disable_defaults = false,
  go = "go",
  goimport = "gopls",
  fillstruct = "gopls",
  gofmt = "gofmt",
  max_line_len = 100,
  tag_transform = false,
  gotests_template = "",
  gotests_template_dir = "",
  comment_placeholder = "",
  icons = { breakpoint = "", currentpos = "" },
  verbose = false,
  lsp_cfg = {
    settings = {
      gopls = {
        gofumpt = false,
        codelenses = {
          gc_details = true,
          generate = true,
          regenerate_cgo = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        diagnosticsDelay = "300ms",
        symbolMatcher = "fuzzy",
        completeUnimported = true,
        staticcheck = false,
        matcher = "Fuzzy",
        usePlaceholders = true,
        analyses = {
          fieldalignment = true,
          nilness = true,
          shadow = true,
          unusedparams = true,
          unusedwrite = true,
        },
      },
    },
  },
  lsp_gofumpt = false,
  lsp_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
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
      ["<leader>cr"] = { vim.cmd.GoRun, "Run", buffer = bufnr },
      ["<leader>cb"] = { vim.cmd.GoBuild, "Build", buffer = bufnr },
      ["<leader>ce"] = { vim.cmd.GoGenReturn, "Generate Return", buffer = bufnr },
      -- ["<leader>dt"] = { require("dap-go").debug_test, "Debug Test", buffer = bufnr },
      ["<leader>tt"] = { vim.cmd.GoTest, "Run Tests", buffer = bufnr },
      ["<leader>ta"] = { vim.cmd.GoAddTest, "Add Test", buffer = bufnr },
      ["<leader>tA"] = { vim.cmd.GoAddAllTest, "Add All Missing Tests", buffer = bufnr },
      ["<leader>tF"] = { vim.cmd.GoTestFile, "Test File", buffer = bufnr },
      ["<leader>tf"] = { vim.cmd.GoTestFunc, "Test Func", buffer = bufnr },
      ["<leader>tp"] = { vim.cmd.GoTestPkg, "Test Package", buffer = bufnr },
    })
  end,
  lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
  lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
  lsp_diag_hdlr = true, -- hook lsp diag handler
  lsp_diag_underline = true,
  -- virtual text setup
  lsp_diag_virtual_text = false,
  lsp_diag_signs = true,
  lsp_diag_update_in_insert = false,
  lsp_document_formatting = true,
  -- set to true: use gopls to format
  -- false if you want to use other formatter tool(e.g. efm, nulls)
  lsp_inlay_hints = {
    enable = true,
    -- Only show inlay hints for the current line
    only_current_line = false,
    -- Event which triggers a refersh of the inlay hints.
    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    -- not that this may cause higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = "CursorHold",
    -- whether to show variable name before type hints with the inlay hints or not
    -- default: false
    show_variable_name = true,
    -- prefix for parameter hints
    parameter_hints_prefix = " ",
    show_parameter_hints = true,
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the lenght of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 6,
    -- The color of the hints
    highlight = "Comment",
  },
  gopls_remote_auto = true, -- add -remote=auto to gopls
  gocoverage_sign = "█",
  sign_priority = 5, -- change to a higher number to override other signs
  dap_debug = true, -- set to false to disable dap
  dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
  dap_debug_gui = true, -- set to true to enable dap gui, highly recommend
  dap_debug_vt = true, -- set to true to enable dap virtual text
  textobjects = true, -- enable default text jobects through treesittter-text-objects
  test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
  verbose_tests = true, -- set to add verbose flag to tests
  run_in_floaterm = true, -- set to true to run in float window. :GoTermClose closes the floatterm
  -- float term recommend if you use richgo/ginkgo with terminal color
  trouble = false, -- true: use trouble to open quickfix
  test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
  luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
}
