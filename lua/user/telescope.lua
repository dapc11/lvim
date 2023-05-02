local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local putils = require("telescope.previewers.utils")

lvim.builtin.telescope.defaults.prompt_prefix = "   "
lvim.builtin.telescope.defaults.path_display = { "truncate" }
lvim.builtin.telescope.file_sorter = require("telescope.sorters").get_fuzzy_file
lvim.builtin.telescope.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter

lvim.builtin.telescope.defaults.mappings.i = {
      ["<C-p>"] = action_layout.toggle_preview,
      ["<C-c>"] = actions.close,
      ["<esc>"] = actions.close,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<C-Down>"] = actions.cycle_history_next,
      ["<C-Up>"] = actions.cycle_history_prev,
      ["<CR>"] = actions.select_default,
      ["<C-h>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-o>"] = actions.select_tab,
}

lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
lvim.builtin.telescope.defaults.mappings.n = {
      ["<C-c>"] = actions.close,
      ["<C-p>"] = action_layout.toggle_preview,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<C-Down>"] = actions.cycle_history_next,
      ["<C-Up>"] = actions.cycle_history_prev,
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
