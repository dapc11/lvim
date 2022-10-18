local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local putils = require("telescope.previewers.utils")
local dropdown_config = {
  center = {
    height = 0.4,
    preview_cutoff = 40,
    prompt_position = "top",
    width = 0.7,
  },
}

lvim.builtin.telescope.pickers = {
  lsp_references = {
    theme = "dropdown",
    initial_mode = "normal",
    layout_config = dropdown_config,
  },
  lsp_definitions = {
    theme = "dropdown",
    initial_mode = "normal",
    layout_config = dropdown_config,
  },
  lsp_declarations = {
    theme = "dropdown",
    initial_mode = "normal",
    layout_config = dropdown_config,
  },
  diagnostics = {
    theme = "dropdown",
    initial_mode = "normal",
    layout_config = dropdown_config,
  },
  lsp_implementations = {
    theme = "dropdown",
    initial_mode = "normal",
    layout_config = dropdown_config,
  },
  find_files = {
    theme = "dropdown",
    previewer = false,
    layout_config = dropdown_config,
  },
  oldfiles = {
    theme = "dropdown",
    previewer = false,
    layout_config = dropdown_config,
  },
  git_files = {
    theme = "dropdown",
    previewer = false,
    layout_config = dropdown_config,
  },
  current_buffer_fuzzy_find = {
    theme = "dropdown",
    layout_config = dropdown_config,
  },
  live_grep = {
    theme = "dropdown",
    layout_config = dropdown_config,
  },
  buffers = {
    theme = "dropdown",
    previewer = false,
    initial_mode = "normal",
    layout_config = dropdown_config,
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

lvim.builtin.telescope.defaults.mappings.i = {
  ["<C-p>"] = action_layout.toggle_preview,
  ["<C-c>"] = actions.close,
  ["<esc>"] = actions.close,
  ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
  ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
  ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
  ["<CR>"] = actions.select_default,
  ["<C-h>"] = actions.select_horizontal,
  ["<C-v>"] = actions.select_vertical,
  ["<C-o>"] = actions.select_tab,
}
lvim.builtin.telescope.defaults.mappings.n = {
  ["<C-p>"] = action_layout.toggle_preview,
  ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
  ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
  ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
  ["<C-c>"] = actions.close,
}

lvim.builtin.telescope.file_previewer = {
  filetype_hook = function(filepath, bufnr, opts)
    -- you could analogously check opts.ft for filetypes
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
