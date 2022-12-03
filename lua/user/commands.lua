local function foreach(tbl, f)
  if not tbl then
    return nil
  end

  local t = {}
  for key, value in pairs(tbl) do
    t[key] = f(value)
  end
  return t
end

local function qf_populate(lines, mode, title)
  if mode == nil or type(mode) == "table" then
    lines = foreach(lines, function(item)
      return { filename = item, lnum = 1, col = 1, text = item }
    end)
    mode = "r"
  end

  vim.fn.setqflist(lines, mode)

  if not title then
    vim.cmd([[
            belowright copen
            wincmd p
        ]])
  else
    vim.cmd(string.format("belowright copen\nwincmd p"))
  end
end

-- send :messages to qflist
local function show_messages()
  local messages = vim.api.nvim_exec("messages", true)
  local entries = {}

  for _, line in ipairs(vim.split(messages, "\n", true)) do
    table.insert(entries, { text = line })
  end

  qf_populate(entries, "r", "Messages")
end

-- send :command output to qflist
local function show_command(command)
  command = command.args

  local output = vim.api.nvim_exec(command, true)
  local entries = {}

  for _, line in ipairs(vim.split(output, "\n", true)) do
    table.insert(entries, { text = line })
  end

  qf_populate(entries, "r", "Command Output")
end

-- messages in qflist
vim.api.nvim_create_user_command("Messages", show_messages, {
  bang = false,
  nargs = 0,
  desc = "Show :messages in qflist",
})

-- command output in qflist
vim.api.nvim_create_user_command("Show", show_command, {
  bang = false,
  nargs = "+",
  desc = "Run Command and show output in qflist",
})
