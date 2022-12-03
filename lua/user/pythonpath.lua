local function match(dir, pattern)
  if string.sub(pattern, 1, 1) == "=" then
    return vim.fn.fnamemodify(dir, ":t") == string.sub(pattern, 2, #pattern)
  else
    return vim.fn.globpath(dir, pattern) ~= ""
  end
end

local function parent_dir(dir)
  return vim.fn.fnamemodify(dir, ":h")
end

local function get_root(pythonpath_file)
  local current = vim.api.nvim_buf_get_name(0)
  local parent = parent_dir(current)

  while 1 do
    if match(parent, pythonpath_file) then
      return parent
    end

    current, parent = parent, parent_dir(parent)
    if parent == current then
      break
    end
  end
  return nil
end

local function file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    local buf_ft = vim.bo.filetype
    if buf_ft ~= "python" or buf_ft == nil then
      return
    end
    local pythonpath_file = ".pythonpath"
    local root = get_root(pythonpath_file)
    if root == nil then
      vim.env.PYTHONPATH = ""
      return
    end
    local absolute_path = root .. "/" .. pythonpath_file
    if file_exists(absolute_path) then
      for line in io.open(absolute_path):lines() do
        vim.env.PYTHONPATH = line
      end
    end
  end,
})
