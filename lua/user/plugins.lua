lvim.plugins = {
  -- Themes
  {
    "dapc11/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        -- sidebars = { "qf", "help", "NvimTree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
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
          highlights.WinSeparator = { bg = colors.bg_sidebar, fg = colors.bg_sidebar }
          highlights.NvimTreeNormal = { bg = colors.red }
          highlights.NvimTreeNormalNC = { bg = colors.yellow }
        end,
      })
    end,
  },

  -- No setup
  "kylechui/nvim-surround",
  {
    "tpope/vim-unimpaired",
    lazy = false,
  },
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "ray-x/go.nvim",
  "ray-x/guihua.lua",
  "NvChad/nvim-colorizer.lua",

  -- Custom config
  { "mfussenegger/nvim-jdtls", event = "VeryLazy" },
  {
    "j-hui/fidget.nvim",
    config = true,
    opts = {
      window = {
        relative = "win", -- where to anchor, either "win" or "editor"
        blend = 0, -- &winblend for the window
        zindex = nil, -- the zindex value for the window
        border = "none", -- style of border for the fidget window
      },
    },
  },

  { "junegunn/vim-easy-align", event = "VeryLazy" },
  { "dapc11/vim-fugitive", event = "VeryLazy" },
  { "mfussenegger/nvim-treehopper", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  { "cuducos/yaml.nvim", event = "VeryLazy" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = true,
    opts = {
      highlight_unlabeled = true,
      case_sensitive = false,
      max_highlighted_traversal_targets = nil,
      highlight_unlabeled_phase_one_targets = false,
      max_phase_one_targets = 0,
    },
  },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "mfussenegger/nvim-dap-python",
    },
  },
  { "AckslD/nvim-pytrize.lua", ft = "python", config = true },
  { "AckslD/swenv.nvim", ft = "python" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "monaqa/dial.nvim",
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "boltlessengineer/bufterm.nvim",
    config = function()
      require("bufterm").setup({
        save_native_terms = true, -- integrate native terminals from `:terminal` command
        start_in_insert = false, -- start terminal in insert mode
        remember_mode = false, -- remember vi_mode of terminal buffer
        enable_ctrl_w = true, -- use <C-w> for window navigating in terminal mode (like vim8)
        terminal = { -- default terminal settings
          buflisted = false, -- whether to set 'buflisted' option
          termlisted = true, -- list terminal in termlist (similar to buflisted)
          fallback_on_exit = true, -- prevent auto-closing window on terminal exit
          auto_close = true, -- auto close buffer on terminal job ends
        },
      })
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = true,
    priority = 999,
    init = function()
      -- These keymaps corresponds to what is setup in .tmux conf
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-left>",
          down = "<C-down>",
          up = "<C-up>",
          right = "<C-right>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose", -- also can use :tabclose
      "DiffviewFileHistory",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  },
  {
    "wellle/targets.vim",
  },
}
