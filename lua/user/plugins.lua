lvim.plugins = {
  "NvChad/nvim-colorizer.lua",
  "kylechui/nvim-surround",
  "uga-rosa/cmp-dictionary",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "monaqa/dial.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-pack/nvim-spectre",
  "tpope/vim-unimpaired",
  "wellle/targets.vim",
  { "dapc11/vim-fugitive", cmd = "Git" },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "telescope",
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = require("user.theme"),
  },
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
  { "mfussenegger/nvim-jdtls", event = "VeryLazy" },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "v", "n" } },
    },
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
    ft = {
      "python",
      "go",
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
  {
    "stevearc/stickybuf.nvim",
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "telescope-fzf-native.nvim",
      { "dapc11/telescope-yaml.nvim", ft = "yaml" },
    },
  },
  {
    "NeogitOrg/neogit",
    keys = { { "<C-g>", "<cmd>Neogit<cr>" } },
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
  { "junegunn/fzf", build = "./install --bin" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("user.fzf"),
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        vim.cmd.UndotreeToggle,
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        func_map = {
          fzffilter = "<C-f>",
          filter = "<C-n>",
          split = "<C-s>",
          vsplit = "<C-v>",
        },
      })
    end,
  },
  {
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
    dependencies = "romgrk/fzy-lua-native",
    config = require("user.wilder"),
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
