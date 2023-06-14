local function getLspName()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  local lsp_names = ""
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if lsp_names ~= "" then
        lsp_names = lsp_names .. ", "
      end
      lsp_names = lsp_names .. client.name
    end
  end
  return "  [" .. lsp_names .. "]"
end

lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = { components.progress }
lvim.builtin.lualine.sections.lualine_z = { getLspName }

local custom_theme = require("lualine.themes.auto")
local colors = require("tokyonight.colors").setup()

custom_theme.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.blue },
  c = { bg = colors.none, fg = colors.fg_sidebar },
}

custom_theme.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.green },
}

custom_theme.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.yellow },
}

custom_theme.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.magenta },
}

custom_theme.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.red },
}

custom_theme.terminal = {
  a = { bg = colors.green1, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.green1 },
}

custom_theme.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

lvim.builtin.lualine.options.theme = custom_theme
