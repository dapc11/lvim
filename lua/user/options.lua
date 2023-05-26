lvim.log.level = "warn"
lvim.transparent_window = true
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = false
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.diagnostics.enable = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.nvimtree.setup.renderer.icons.show.file = false
lvim.builtin.nvimtree.setup.renderer.group_empty = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.highlights.background.italic = false
lvim.builtin.bufferline.highlights.buffer_selected.bold = true
lvim.builtin.bufferline.highlights.buffer_selected.italic = false
lvim.builtin.bufferline.options.always_show_bufferline = false
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.show_close_icon = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.show_tab_indicators = false
lvim.builtin.bufferline.options.diagnostics = false
lvim.builtin.bufferline.options.modified_icon = ""
lvim.builtin.bufferline.options.offsets = {
  {
    filetype = "NvimTree",
    highlight = "NvimTreeNormal",
    padding = 0,
    text = "Explorer",
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

require("lvim.lsp.manager").setup("marksman")
