lvim.builtin.cmp.completion = {
  completion = {
    completeopt = "menu, menuone, noinsert",
  },
}
lvim.builtin.cmp.completion.keyword_length = 1

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
  { name = "nvim_lsp_signature_help" },
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

local methods = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
methods.has_words_before = has_words_before

---@deprecated use M.methods.has_words_before instead
methods.check_backspace = function()
  return not has_words_before()
end

local T = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function feedkeys(key, mode)
  vim.api.nvim_feedkeys(T(key), mode, true)
end

methods.feedkeys = feedkeys

---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    return false
  end

  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  ---sets the current buffer's luasnip to the one nearest the cursor
  ---@return boolean true if a node is found, false otherwise
  local function seek_luasnip_cursor_node()
    -- TODO(kylo252): upstream this
    -- for outdated versions of luasnip
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local exit_node = snippet.insert_nodes[0]

    local pos = win_get_cursor(0)
    pos[1] = pos[1] - 1

    -- exit early if we're past the exit node
    if exit_node then
      local exit_pos_end = exit_node.mark:pos_end()
      if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    node = snippet.inner_first:jump_into(1, true)
    while node ~= nil and node.next ~= nil and node ~= snippet do
      local n_next = node.next
      local next_pos = n_next and n_next.mark:pos_begin()
      local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
        or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

      -- Past unmarked exit node, exit early
      if n_next == nil or n_next == snippet.next then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end

      if candidate then
        luasnip.session.current_nodes[get_current_buf()] = node
        return true
      end

      local ok
      ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
      if not ok then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    -- No candidate, but have an exit node
    if exit_node then
      -- to jump to the exit node, seek to snippet
      luasnip.session.current_nodes[get_current_buf()] = snippet
      return true
    end

    -- No exit node, exit from snippet
    snippet:remove_from_jumplist()
    luasnip.session.current_nodes[get_current_buf()] = nil
    return false
  end

  if dir == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
end

methods.jumpable = jumpable

local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then
  return
end
local neogen = require("neogen")
local tab = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif neogen.jumpable() then
    neogen.jump_next()
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  elseif methods.jumpable(1) then
    luasnip.jump(1)
  elseif methods.has_words_before() then
    -- cmp.complete()
    fallback()
  else
    fallback()
  end
end
local shift_tab = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif neogen.jumpable(true) then
    neogen.jump_prev()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end
lvim.builtin.cmp.mapping["<S-Tab>"].i = shift_tab
lvim.builtin.cmp.mapping["<S-Tab>"].s = shift_tab
lvim.builtin.cmp.mapping["<Tab>"].i = tab
lvim.builtin.cmp.mapping["<Tab>"].s = tab
