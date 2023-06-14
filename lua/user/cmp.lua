local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok or cmp == nil then
  cmp = {
    mapping = function(...) end,
    setup = { filetype = function(...) end, cmdline = function(...) end },
    config = { sources = function(...) end },
  }
end
lvim.builtin.cmp.formatting = {
  source_names = {
    nvim_lsp = "(LSP)",
    path = "(Path)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    treesitter = "(TreeSitter)",
    dictionary = "(Dict)",
  },
}
lvim.builtin.cmp.sources = {
  {
    name = "nvim_lsp",
    entry_filter = function(entry, ctx)
      return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
    end,
  },
  { name = "buffer", max_item_count = 5, keyword_length = 5 },
  { name = "path", max_item_count = 5 },
  { name = "luasnip", max_item_count = 3 },
  { name = "nvim_lua" },
  { name = "treesitter" },
}

lvim.builtin.cmp.experimental = {
  ghost_text = false,
  native_menu = false,
  custom_menu = true,
}

local dict = require("cmp_dictionary")
dict.setup({
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = "wn %s -over",
  async = false,
  sqlite = false,
  max_items = -1,
  capacity = 5,
  debug = false,
})

dict.switcher({
  filetype = {
    markdown = "en.dict",
  },
  spelllang = {
    en = "en.dict",
  },
})

cmp.setup.filetype({ "markdown" }, {
  sources = cmp.config.sources({
    { name = "dictionary", keyword_length = 2 },
  }),
})

cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
  sources = cmp.config.sources({
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = "cmp_dictionary", keyword_length = 2 },
  }),
})

lvim.builtin.cmp.cmdline.enable = true
