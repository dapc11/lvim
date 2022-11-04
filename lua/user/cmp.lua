local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok or cmp == nil then
  cmp = {
    mapping = function(...) end,
    setup = { filetype = function(...) end, cmdline = function(...) end },
    config = { sources = function(...) end },
  }
end
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

lvim.builtin.cmp.sources = {
  {
    name = "nvim_lsp",
    entry_filter = function(entry, ctx)
      return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
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
local cmp_sources = {
  nvim_lsp = "[Lsp]",
  nvim_lua = "[Lua]",
  luasnip = "[Snip]",
  buffer = "[Buf]",
  path = "[Path]",
}

lvim.builtin.cmp.formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(entry, vim_item)
    if entry.source.name == "cmdline" then
      vim_item.kind = "⌘"
      vim_item.menu = ""
      return vim_item
    end
    vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind
    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    return vim_item
  end,
}

-- Set configuration for specific filetype.
cmp.setup.filetype({ "gitcommit" }, {
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
  }),
})

lvim.builtin.cmp.cmdline.options = {
  {
    type = ":",
    sources = {
      { name = "path" },
      { name = "cmdline", keyword_length = 2, keyword_pattern = [=[[^[:blank:]\!]*]=] },
    },
  },
  {
    type = { "/", "?" },
    sources = {
      { name = "buffer" },
    },
  },
}
