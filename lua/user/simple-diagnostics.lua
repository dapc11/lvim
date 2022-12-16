local prev_line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
local prev_bufnr = vim.api.nvim_get_current_buf()
local set = false
local virtual_text = true
local message_area = false
local signs = false

local severity = {
  { texthl = "LspDiagnosticsVirtualTextError", sign = "DiagnosticSignError" },
  { texthl = "LspDiagnosticsVirtualTextWarning", sign = "DiagnosticSignWarning" },
  { texthl = "LspDiagnosticsVirtualTextInformation", sign = "DiagnosticSignInfo" },
  { texthl = "LspDiagnosticsVirtualTextHint", sign = "DiagnosticSignHint" },
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
    vim.api.nvim_buf_set_extmark(bufnr, 1, prev_line_nr, 0, opts)
  end
  set = false
end

local function printDiagnostics(buf, line)
  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(buf, line)

  prev_bufnr = buf
  prev_line_nr = line

  if vim.tbl_isempty(line_diagnostics) then
    clear(buf)
    return
  end

  if set then
    return
  end
  prev_bufnr = buf
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

  diagnostic_message = diagnostic_message .. string.format("%s%s", signs and text or "", diagnostic.message or "")

  if message_area then
    print(diagnostic_message)
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

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
  pattern = "*",
  group = augroup,
  callback = function()
    printDiagnostics(vim.api.nvim_get_current_buf(), vim.api.nvim_win_get_cursor(0)[1] - 1)
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufEnter" }, {
  pattern = "*",
  group = augroup,
  callback = function()
    clear(prev_bufnr)
  end,
})
