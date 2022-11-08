lvim.log.level = "warn"
lvim.format_on_save = false
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
lvim.colorscheme = "github_dark"
lvim.builtin.alpha.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.diagnostics.enable = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.nvimtree.setup.renderer.icons.show.file = false
lvim.builtin.nvimtree.setup.renderer.group_empty = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = false
lvim.builtin.indentlines.options.show_current_context = false
lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = false
lvim.builtin.breadcrumbs.active = true
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
    highlight = "PanelHeading",
    padding = 0,
    text = "Explorer",
  },
}
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.code_lens_refresh = false
lvim.builtin.cmp.completion = {
  completion = {
    completeopt = "menu, menuone, noinsert",
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

vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.title = true
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

vim.opt.shortmess:append("c")
vim.g.python3_host_prog = "~/.envs/nvim/bin/python3"

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
