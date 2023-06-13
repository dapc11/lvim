lvim.log.level = "warn"
lvim.transparent_window = true
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

local lvim_dashboard = require("lvim.core.alpha.dashboard")
local sections = lvim_dashboard.get_sections()
local fzf = require("fzf-lua")
lvim.builtin.alpha.dashboard.section.buttons.entries = {
  { "f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>FzfLua files<CR>" },
  { "n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>" },
  { "p", lvim.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>" },
  { "r", lvim.icons.ui.History .. "  Recent files", "<CMD>FzfLua oldfiles <CR>" },
  { "t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>FzfLua live_grep<CR>" },
  {
    "c",
    lvim.icons.ui.Gear .. "  Configuration",
    "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
  },
  { "q", lvim.icons.ui.Close .. "  Quit", "<CMD>quit<CR>" },
}
lvim.builtin.terminal.active = false
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.renderer.root_folder_label = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.diagnostics.enable = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.nvimtree.setup.renderer.icons.show.file = false
lvim.builtin.nvimtree.setup.renderer.group_empty = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.highlights.background.italic = false
lvim.builtin.bufferline.highlights.buffer_selected.bold = true
lvim.builtin.bufferline.highlights.buffer_selected.italic = false
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.show_close_icon = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.show_tab_indicators = false
lvim.builtin.bufferline.options.diagnostics = false
lvim.builtin.bufferline.options.modified_icon = ""
lvim.builtin.bufferline.options.offsets = {
  {
    filetype = "NvimTree",
    highlight = "Directory",
    padding = 0,
    text = function()
      return string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
    end,
  },
}

lvim.builtin.project.patterns = {
  "ruleset2.0.yaml",
  ".git",
  "_darcs",
  ".hg",
  ".bzr",
  ".svn",
  "Makefile",
  "package.json",
  "script_version.txt",
  "drc-report",
  "image-design-rule-check-report.html",
}

vim.opt.relativenumber = true
vim.opt.timeoutlen = 250
vim.filetype.add({
  extension = {
    tpl = "gotmpl",
  },
  pattern = {
    [".*/templates/.*tpl"] = "gotmpl",
    [".*/templates/.*yaml"] = "gotmpl",
    [".*/templates/.*.yml"] = "gotmpl",
  },
})
