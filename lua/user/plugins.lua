lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = require("user.theme"),
  },
  "kylechui/nvim-surround",
  "tpope/vim-unimpaired",
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("user.lsp.go"),
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  "NvChad/nvim-colorizer.lua",
  "wellle/targets.vim",
  "monaqa/dial.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "mfussenegger/nvim-jdtls", event = "VeryLazy" },
  {
    "j-hui/fidget.nvim",
    opts = {
      window = {
        blend = 0,
      },
    },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "v", "n" } },
    },
  },
  "dapc11/vim-fugitive",
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
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
    "alexghergh/nvim-tmux-navigation",
    priority = 999,
    opts = {
      disable_when_zoomed = true,
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
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  },
  "nvim-pack/nvim-spectre",
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    commit = "71bb1da621a48856c7f8ca10e674f2ac8c0a9005",
    config = function()
      local utils = require("lvim.utils")
      local path = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "nvim-treesitter")
      vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
      require("lvim.core.treesitter").setup()
    end,
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
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
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    dependencies = {
      "telescope-fzf-native.nvim",
      "dapc11/telescope-yaml.nvim",
    },
    lazy = true,
    cmd = "Telescope",
    enabled = lvim.builtin.telescope.active,
  },
  { "TimUntersberger/neogit", keys = { { "<C-g>", "<cmd>Neogit<cr>" } }, dependencies = "nvim-lua/plenary.nvim" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
