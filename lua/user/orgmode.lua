local status, ts = pcall(require, "nvim-treesitter")
if not status then
  print("Failed to load Treesitter.")
  return
end
local status, orgmode = pcall(require, "orgmode")
if not status then
  print("Failed to load Orgmode.")
  return
end
-- Load custom treesitter grammar for org filetype
orgmode.setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { "org" },
  },
  ensure_installed = { "org" }, -- Or run :TSUpdate org
})

orgmode.setup({
  org_agenda_files = { "~/org/*" },
  org_default_notes_file = "~/org/notes.org",
})
