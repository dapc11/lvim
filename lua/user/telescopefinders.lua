local M = {}
local strings = require("plenary.strings")
local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
  return
end
local themes = require("telescope.themes")

function M.repo_grep()
  telescope.live_grep({
    cwd = "~/repos/",
    path_display = { "truncate", shorten = { len = 1, exclude = { 1, -1 } } },
    prompt_title = "Repos",
    layout_config = {
      height = 0.85,
      width = 0.75,
    },
  })
end

function M.repo_fd()
  telescope.find_files({
    cwd = "~/repos/",
    prompt_title = "Repos",
    layout_config = {
      height = 0.85,
    },
  })
end

function M.git_unstaged()
  telescope.git_files({ git_command = { "git", "ls-files", "--modified", "--exclude-standard" } })
end

function M.spell_check()
  telescope.spell_suggest(themes.get_cursor({
    prompt_title = "",
    layout_config = {
      height = 0.25,
      width = 0.25,
    },
  }))
end

local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local entry_display = require("telescope.pickers.entry_display")
local make_entry = require("telescope.make_entry")

local width = 0

local function visit_yaml_node(node, _, yaml_path, result, file_path, bufnr)
  local key = ""
  local value = ""
  if node:type() == "block_mapping_pair" then
    local field_key = node:field("key")[1]
    local field_value = node:field("value")[1]
    key = vim.treesitter.get_node_text(field_key, bufnr)
    value = vim.treesitter.get_node_text(field_value, bufnr)
  end

  if key ~= nil and string.len(key) > 0 then
    table.insert(yaml_path, key)
    local full_path = table.concat(yaml_path, ".")
    width = math.max(width, strings.strdisplaywidth(full_path or ""))
    local line, col = node:start()
    table.insert(result, {
      lnum = line + 1,
      col = col + 1,
      bufnr = bufnr,
      filename = file_path,
      value = value,
      text = full_path,
    })
  end

  for node, name in node:iter_children() do
    visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
  end

  if key ~= nil and string.len(key) > 0 then
    table.remove(yaml_path, table.maxn(yaml_path))
  end
end

local function gen_from_yaml_nodes(opts)
  local displayer = entry_display.create({
    separator = " │ ",
    items = {
      { width = 5 },
      { width = width },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.lnum, "TelescopeResultsSpecialComment" },
      {
        entry.text,
        function()
          return {}
        end,
      },
      { entry.value },
    })
  end

  return function(entry)
    return make_entry.set_default_entry_mt({
      ordinal = entry.text,
      display = make_display,
      filename = entry.filename,
      lnum = entry.lnum,
      text = entry.text,
      value = entry.value,
      col = entry.col,
    }, opts)
  end
end

function M.yaml_find(opts)
  opts = opts or {}
  local yaml_path = {}
  local result = {}
  local word = opts.search or vim.fn.expand("<cword>")
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
  local tree = vim.treesitter.get_parser(bufnr, ft):parse()[1]
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local root = tree:root()
  for node, name in root:iter_children() do
    visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
  end

  -- return result
  pickers.new(opts, {
    prompt_title = "YAML symbols" .. word,
    -- theme = "dropdown",
    finder = finders.new_table({
      results = result,
      entry_maker = opts.entry_maker or gen_from_yaml_nodes(opts),
    }),
    layout_config = {
      height = 0.85,
      width = 0.75,
    },
    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts),
  }):find()
end

return M
