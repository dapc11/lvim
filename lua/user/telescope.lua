local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local action_generate = require("telescope.actions.generate")
local putils = require("telescope.previewers.utils")

local default_config = {
  theme = "ivy",
  initial_mode = "insert",
}

local file_config = {
  theme = "ivy",
  preview = false,
}

lvim.builtin.telescope.pickers = {
  lsp_references = default_config,
  lsp_definitions = default_config,
  lsp_declarations = default_config,
  lsp_document_symbols = default_config,
  lsp_dynamic_workspace_symbols = default_config,
  diagnostics = default_config,
  lsp_implementations = default_config,
  find_files = file_config,
  oldfiles = file_config,
  git_files = file_config,
  current_buffer_fuzzy_find = {
    theme = "ivy",
  },
  live_grep = {
    theme = "ivy",
  },
  buffers = {
    theme = "ivy",
    previewer = false,
    initial_mode = "normal",
    mappings = {
      n = {
            ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            ["dd"] = actions.delete_buffer,
      },
      i = {
            ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
      },
    },
  },
}

lvim.builtin.telescope.defaults.prompt_prefix = "   "
lvim.builtin.telescope.defaults.path_display = { "truncate" }
lvim.builtin.telescope.file_sorter = require("telescope.sorters").get_fuzzy_file
lvim.builtin.telescope.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter
local actions_layout = require("telescope.actions.layout")

lvim.builtin.telescope.defaults.mappings.i = {
      ["<C-p>"] = action_layout.toggle_preview,
      ["<C-c>"] = actions.close,
      ["<esc>"] = actions.close,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<C-Down>"] = actions.cycle_history_next,
      ["<C-Up>"] = actions.cycle_history_prev,
      ["<M-right>"] = actions_layout.cycle_layout_next,
      ["<M-left>"] = actions_layout.cycle_layout_prev,
      ["<CR>"] = actions.select_default,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-o>"] = actions.select_tab,
      ["<C-h>"] = action_generate.which_key({
    name_width = 20,   -- typically leads to smaller floats
    max_height = 0.5,  -- increase potential maximum height
    separator = " > ", -- change sep between mode, keybind, and name
    close_with_action = true,
  }),
}

lvim.builtin.telescope.defaults.mappings.n = {
      ["<C-p>"] = action_layout.toggle_preview,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<C-c>"] = actions.close,
      ["<C-Down>"] = actions.cycle_history_next,
      ["<C-Up>"] = actions.cycle_history_prev,
      ["<M-right>"] = actions_layout.cycle_layout_next,
      ["<M-left>"] = actions_layout.cycle_layout_prev,
      ["?"] = action_generate.which_key({
    name_width = 20,   -- typically leads to smaller floats
    max_height = 0.5,  -- increase potential maximum height
    separator = " > ", -- change sep between mode, keybind, and name
    close_with_action = true,
  }),
}

lvim.builtin.telescope.file_previewer = {
  filetype_hook = function(filepath, bufnr, opts)
    local excluded = vim.tbl_filter(function(ending)
      return filepath:match(ending)
    end, {
      ".*%.jar",
      ".*%.tar.gz",
    })
    if not vim.tbl_isempty(excluded) then
      putils.set_preview_message(bufnr, opts.winid, string.format("I don't like %s files!", excluded[1]:sub(5, -1)))
      return false
    end
    return true
  end,
  filesize_hook = function(filepath, bufnr, opts)
    local max_bytes = 10000
    local cmd = { "head", "-c", max_bytes, filepath }
    require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
  end,
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "harpoon")
  pcall(telescope.load_extension, "zk")
end
