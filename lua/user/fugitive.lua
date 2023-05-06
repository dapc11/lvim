local get_buffer_list = function()
  return vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)")
end

local get_matching_buffers = function(pattern)
  local buffers = get_buffer_list()
  pattern = vim.regex(pattern)
  return vim.tbl_filter(function(v)
    return pattern:match_str(vim.fn.bufname(v)) ~= nil
  end, buffers)
end

local wipe_matching_buffers = function(pattern)
  local matchlist = get_matching_buffers(pattern)
  local count = vim.tbl_count(matchlist)
  if count < 1 then
    return
  end
  vim.api.nvim_exec("bw " .. vim.fn.join(matchlist, " "), true)
end

vim.api.nvim_create_user_command("Gdiffoff", function()
  wipe_matching_buffers("fugitive://")
end, {})
