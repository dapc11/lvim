local M = {}
function M.run(executor)
  local script = vim.fn.expand("%:p")
  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_win_set_buf(win, buf)
  bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "output:" })
  table.insert(executor, script)
  vim.fn.jobstart(executor, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end,
  })
end

return M
