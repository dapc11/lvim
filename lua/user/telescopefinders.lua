local M = {}
local strings = require("plenary.strings")
local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
  return
end
local themes = require("telescope.themes")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")

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
  local rel_path = string.gsub(vim.fn.system("git rev-parse --show-cdup"), "^%s*(.-)%s*$", "%1")
  if vim.v.shell_error ~= 0 then
    return
  end
  pickers.new({
      results_title = "Modified on current branch",
      finder = finders.new_oneshot_job({
        "git",
        "diff",
        "--name-only",
        "HEAD",
      }),
      sorter = sorters.get_fuzzy_file(),
      previewer = previewers.new_termopen_previewer({
        get_command = function(entry)
          return {
            "git",
            "diff",
            "HEAD",
            "--",
            rel_path .. entry.value,
          }
        end,
      }),
    })
    :find()
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

return M
