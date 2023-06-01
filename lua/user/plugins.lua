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
        highlights.WinSeparator = { bg = colors.none, fg = colors.blue7 }
        highlights.NvimTreeWinSeparator = { link = "WinSeparator" }
        highlights.FloatBorder = { bg = colors.bg, fg = colors.blue7 }
        highlights.TelescopeBorder = { bg = colors.bg, fg = colors.blue7 }
        highlights.WhichKeyFloat = { bg = colors.bg }
      end,
    },
  },

  -- No setup
  "kylechui/nvim-surround",
  { "tpope/vim-unimpaired", lazy = false },
  "hrsh7th/cmp-nvim-lsp-signature-help",
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup(require("user.lsp.go"))
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*.go" },
        callback = function()
          vim.cmd([[silent! lua require("go.format").goimport()]])
        end,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
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
    {
      "stevearc/aerial.nvim",
      opts = {
        layout = {
          max_width = { 200, 0.15 },
          width = 0.15,
        },
        close_automatic_events = { "switch_buffer", "unsupported" },
        show_guides = true,
      },
      keys = {
        { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle outline" },
      },
      -- Optional dependencies
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
    },
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
}
