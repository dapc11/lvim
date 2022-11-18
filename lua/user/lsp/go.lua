local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

require("go").setup({
  disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
  go = "go", -- go command, can be go[default] or go1.18beta1
  goimport = "gopls", -- goimport command, can be gopls[default] or goimport
  fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
  gofmt = "gofmt", --gofmt cmd,
  max_line_len = 100,
  tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
  gotests_template = "", -- sets gotests -template parameter (check gotests for details)
  gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
  comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
  icons = { breakpoint = "", currentpos = "" }, -- setup to `false` to disable icons setup
  verbose = false, -- output loginf in messages
  lsp_cfg = {
    settings = {
      gopls = {
        gofumpt = false, -- A stricter gofmt
        codelenses = {
          gc_details = true, -- Toggle the calculation of gc annotations
          generate = true, -- Runs go generate for a given directory
          regenerate_cgo = true, -- Regenerates cgo definitions
          test = true,
          tidy = true, -- Runs go mod tidy for a module
          upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
          vendor = true, -- Runs go mod vendor for a module
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
        usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
        analyses = {
          fieldalignment = true, -- find structs that would use less memory if their fields were sorted
          nilness = true, -- check for redundant or impossible nil comparisons
          shadow = true, -- check for possible unintended shadowing of variables
          unusedparams = true, -- check for unused parameters of functions
          unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
        },
      },
    },
  }, -- true: use non-default gopls setup specified in go/lsp.lua
  -- false: do nothing
  -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
  --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
  lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("n", "<leader>Cg", "<cmd>GoGenerate", "Go Generate")
    map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("n", "<leader>r", "<cmd>GoRun<Cr>", "Run")
    map("n", "<leader>Cb", "<cmd>GoBuild<Cr>", "Build")
    map("n", "<leader>Ce", "<cmd>GoGenReturn<Cr>", "Generate Return")
    map("n", "<leader>Dt", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
    map("n", "<leader>Tt", "<cmd>GoTest<cr>", "Run Tests")
    map("n", "<leader>Ta", "<cmd>GoAddTest<cr>", "Add Test")
    map("n", "<leader>TA", "<cmd>GoAddAllTest<cr>", "Add All Missing Tests")
    map("n", "<leader>TF", "<cmd>GoTestFile<cr>", "Test File")
    map("n", "<leader>Tf", "<cmd>GoTestFunc<cr>", "Test Func")
    map("n", "<leader>Tp", "<cmd>GoTestPkg<cr>", "Test Package")
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
  gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
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
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "*.go" },
--   callback = function()
--     local _, _ = pcall(vim.lsp.codelens.refresh)
--   end,
-- })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    vim.cmd([[silent! lua require('go.format').goimport()]])
  end,
})
