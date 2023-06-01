local prev_line = vim.api.nvim_win_get_cursor(0)[1] - 1
local prev_buf = vim.api.nvim_get_current_buf()
local set = false
local virtual_text = true
local message_area = true
local signs = false

local severity = {
  { texthl = "DiagnosticError", sign = "DiagnosticSignError" },
  { texthl = "DiagnosticWarn", sign = "DiagnosticSignWarning" },
  { texthl = "DiagnosticInfo", sign = "DiagnosticSignInfo" },
  { texthl = "DiagnosticHint", sign = "DiagnosticSignHint" },
}

local function clear(bufnr)
  if not set then
    return
  end

  if message_area then
    print(" ")
  end

  if virtual_text then
    local opts = {
      id = 1,
      virt_text = { { "", "" } },
      virt_text_pos = "eol",
    }
    vim.api.nvim_buf_set_extmark(bufnr, 1, prev_line, 0, opts)
  end
  set = false
end

-- Function to print colored text to the message area
local function printColoredText(message, highlight_group)
  local echo_table = { { message, highlight_group } }
  vim.api.nvim_echo(echo_table, true, {})
end

local function printDiagnostics(buf, line)
  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(buf, line)
  prev_buf = buf
  prev_line = line

  if vim.tbl_isempty(line_diagnostics) then
    clear(buf)
    return
  end

  if set then
    return
  end
  prev_buf = buf
  set = true

  local diagnostic_message = ""
  local diagnostic = line_diagnostics[#line_diagnostics]
  local text = vim.fn.sign_getdefined(severity[diagnostic.severity].sign)

  local count = 0
  for _ in pairs(text) do
    count = count + 1
  end
  if count >= 1 then
    text = text[1].text
  else
    text = ""
  end

  diagnostic_message = diagnostic_message
    .. string.format(
      "%s[%s]: %s%s",
      diagnostic.source or "",
      diagnostic.code or "",
      signs and text or "",
      diagnostic.message or ""
    )

  if message_area then
    stripped, _ = diagnostic_message:gsub("\n", "")
    printColoredText(stripped, severity[diagnostic.severity].texthl)
  end

  if virtual_text then
    local opts = {
      id = 1,
      virt_text = { { diagnostic_message, severity[diagnostic.severity].texthl } },
      virt_text_pos = "eol",
    }
    vim.api.nvim_buf_set_extmark(buf, 1, line, 0, opts)
  end
end

local augroup = vim.api.nvim_create_augroup("simple-diagnostics", { clear = true })

lvim.autocommands = {
  {
    { "CursorMoved", "InsertEnter", "BufEnter" },
    {
      group = augroup,
      pattern = { "*" },
      callback = function()
        clear(prev_buf)
      end,
    },
  },
  {
    { "CursorHold", "InsertLeave" },
    {
      pattern = "*",
      group = augroup,
      callback = function()
        printDiagnostics(vim.api.nvim_get_current_buf(), vim.api.nvim_win_get_cursor(0)[1] - 1)
      end,
    },
  },
}
