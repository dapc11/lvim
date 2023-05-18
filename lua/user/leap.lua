local function search_ref()
  local ref = require("illuminate.reference").buf_get_references(vim.api.nvim_get_current_buf())
  if not ref or #ref == 0 then
    return false
  end

  local targets = {}
  for _, v in pairs(ref) do
    table.insert(targets, {
      pos = { v[1][1] + 1, v[1][2] + 1 },
    })
  end

  require("leap").leap({ targets = targets, target_windows = { vim.api.nvim_get_current_win() } })

  return true
end

lvim.builtin.which_key.mappings["fr"] = { search_ref, "Search reference in visible text" }
