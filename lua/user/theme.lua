return {
  style = "storm",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    sidebars = "dark",
    floats = "dark",
  },
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.bg = "#24292e"
    colors.bg_sidebar = "#282c34"
    colors.bg_float = "#24292e"
    colors.git.change = "#7aa2f7"
    colors.git.add = "#98c379"
    colors.git.delete = "#e06c75"
    colors.red = "#e06c75"
  end,
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    local colors = require("tokyonight.colors").setup()
    highlights.LeapBackdrop = { link = "Comment" }
    highlights.LeapMatch = {
      fg = colors.fg_dark,
      underline = true,
      bold = true,
    }
    highlights.LeapLabelPrimary = {
      fg = colors.blue,
      underline = true,
      bold = true,
    }
    highlights.LeapLabelSecondary = {
      fg = colors.red,
    }
    highlights.LeapLabelSelected = {
      fg = colors.green1,
    }
    highlights.WinSeparator = { bg = colors.none, fg = colors.blue7 }
    highlights.NvimTreeWinSeparator = { link = "WinSeparator" }
    highlights.FloatBorder = { bg = colors.bg, fg = colors.blue7 }
    highlights.TelescopeBorder = { bg = colors.bg, fg = colors.blue7 }
    highlights.NeogitDiffAdd = { fg = colors.green }
    highlights.NeogitDiffDelete = { fg = colors.red }
    highlights.NeogitDiffContextHighlight = { fg = colors.fg }
    highlights.NeogitHunkHeaderHighlight = { fg = colors.fg, bold = true }
    highlights.NeogitHunkHeader = { fg = colors.blue, bold = true }
    highlights.WhichKeyFloat = { bg = colors.bg }
    highlights.BqfPreviewFloat = { bg = colors.bg }
    highlights.Directory = { bold = true }
    highlights.NvimTreeFileDirty = { fg = colors.git.change, bold = true }
    highlights.NvimTreeGitDirty = { fg = colors.git.change, bold = true }
  end,
}
