lvim.plugins = {
  -- Themes
  {
    "dapc11/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        theme_style = "dark",
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },

  -- No setup
  "kylechui/nvim-surround",
  {
    "tpope/vim-unimpaired",
    lazy = false,
  },
  "hrsh7th/cmp-cmdline",
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
  {
    "christianchiarulli/harpoon",
    config = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },
  { "junegunn/vim-easy-align", event = "VeryLazy" },
  { "dapc11/vim-fugitive", event = "VeryLazy" },
  { "mfussenegger/nvim-treehopper", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  { "cuducos/yaml.nvim", event = "VeryLazy" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = true,
    init = function()
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LeapMatch", {
        fg = "#c9d1d9",
        underline = true,
        bold = true,
      })
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
        fg = "#539bf5",
        underline = true,
        bold = true,
      })
      vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
        fg = "#e5534b",
      })
      vim.api.nvim_set_hl(0, "LeapLabelSelected", {
        fg = "#57ab5a",
      })
    end,
    opts = {
      highlight_unlabeled = false,
      case_sensitive = false,
      max_highlighted_traversal_targets = nil,
      highlight_unlabeled_phase_one_targets = true,
      max_phase_one_targets = nil,
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
  { "danymat/neogen", config = true, dependencies = "nvim-treesitter/nvim-treesitter" },
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
  { "boltlessengineer/bufterm.nvim", config = true },
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
}
