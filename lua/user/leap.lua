local function get_line_starts(winid)
  local wininfo = vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line(".")

  -- Get targets.
  local targets = {}
  local lnum = wininfo.topline
  while lnum <= wininfo.botline do
    local fold_end = vim.fn.foldclosedend(lnum)
    -- Skip folded ranges.
    if fold_end ~= -1 then
      lnum = fold_end + 1
    else
      if lnum ~= cur_line then
        table.insert(targets, { pos = { lnum, 1 } })
      end
      lnum = lnum + 1
    end
  end
  -- Sort them by vertical screen distance from cursor.
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
  local function screen_rows_from_cur(t)
    local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
    return math.abs(cur_screen_row - t_screen_row)
  end

  table.sort(targets, function(t1, t2)
    return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
  end)

  if #targets >= 1 then
    return targets
  end
end

local M = {}
local leap = require("leap")
function M.leap_to_line()
  local winid = vim.api.nvim_get_current_win()
  leap.leap({
    target_windows = { winid },
    targets = get_line_starts(winid),
  })
end

function M.leap_to_window()
  leap.leap({
    target_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end, vim.api.nvim_tabpage_list_wins(0)),
  })
end

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
vim.api.nvim_set_hl(0, "LeapMatch", {
  fg = "#c9d1d9",
  underline = true,
  bold = true,
})
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
  fg = "#539bf5",
  underline = true,
  bold = true,
})
vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
  fg = "#e5534b",
})
vim.api.nvim_set_hl(0, "LeapLabelSelected", {
  fg = "#57ab5a",
})
leap.opts.highlight_unlabeled_phase_one_targets = true
leap.opts.case_sensitive = false
leap.add_default_mappings()
vim.keymap.set({ "n", "x", "o" }, "f", function()
  require("leap").leap({
    target_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end, vim.api.nvim_tabpage_list_wins(0)),
  })
end)
return M
