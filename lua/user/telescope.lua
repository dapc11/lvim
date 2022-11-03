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

local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function stopinsert(callback)
    return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function()
            callback(prompt_bufnr)
        end)
    end
end

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
  ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
  ["<C-h>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
  ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
  ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
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
  ["<C-o>"] = actions_layout.toggle_preview,
  ["<C-v>"] = custom_actions.multi_selection_open_vertical,
  ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
  ["<C-t>"] = custom_actions.multi_selection_open_tab,
  ["<CR>"] = custom_actions.multi_selection_open,
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
