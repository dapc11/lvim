
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
vim.api.nvim_set_hl(0, "LeapMatch", {
  fg = "white",
  underline = true,
  nocombine = true,
})
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
  fg = "white",
  bg = "#264466",
  nocombine = true,
})
require("leap").opts.highlight_unlabeled_phase_one_targets = true
require("leap").add_default_mappings()
