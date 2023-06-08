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
    highlights.WhichKeyFloat = { bg = colors.bg }
  end,
}
