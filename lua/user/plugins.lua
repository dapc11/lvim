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
    opts = {
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
        highlights.WinSeparator = { bg = colors.bg_sidebar, fg = colors.bg_sidebar }
        highlights.TelescopeBorder = { bg = colors.bg, fg = colors.blue7 }
      end,
    },
  },

  -- No setup
  "kylechui/nvim-surround",
  { "tpope/vim-unimpaired", lazy = false },
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "ray-x/go.nvim",
  "ray-x/guihua.lua",
  "NvChad/nvim-colorizer.lua",
  "wellle/targets.vim",
  "monaqa/dial.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Custom config
  { "mfussenegger/nvim-jdtls", event = "VeryLazy" },
  {
    "j-hui/fidget.nvim",
    opts = {
      window = {
        relative = "win", -- where to anchor, either "win" or "editor"
        blend = 0, -- &winblend for the window
        zindex = nil, -- the zindex value for the window
        border = "none", -- style of border for the fidget window
      },
    },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "", mode = { "v", "n" } },
    },
  },
  { "dapc11/vim-fugitive", event = "VeryLazy" },
  { "mfussenegger/nvim-treehopper", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  { "cuducos/yaml.nvim", ft = "yaml" },
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
  { "AckslD/nvim-pytrize.lua", ft = "python" },
  { "AckslD/swenv.nvim", ft = "python" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "boltlessengineer/bufterm.nvim",
    opts = {
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
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    priority = 999,
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-left>",
        down = "<C-down>",
        up = "<C-up>",
        right = "<C-right>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    },
  },
  { "folke/todo-comments.nvim", event = "BufRead" },
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
    "stevearc/dressing.nvim",
    opts = {
      select = {
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = "telescope",
              telescope = require("telescope.themes").get_dropdown({
                layout_config = {
                  height = function(_, _, max_lines)
                    return math.min(max_lines, 30)
                  end,
                },
              }),
            }
          end
        end,
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<C-r>",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Replace in file",
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = {
      {
        "<leader>a",
        "<cmd>Lspsaga outline<cr>",
        desc = "Outline",
      },
    },
    config = function()
      require("lspsaga").setup({
        ui = {
          -- This option only works in Neovim 0.9
          title = true,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "rounded",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "",
          incoming = " ",
          outgoing = " ",
          hover = " ",
          kind = {},
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 30,
          preview_width = 0.4,
          show_detail = true,
          auto_preview = true,
          auto_refresh = true,
          auto_close = true,
          auto_resize = false,
          custom_sort = nil,
          keys = {
            expand_or_jump = "<cr>",
            quit = "q",
          },
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
}
