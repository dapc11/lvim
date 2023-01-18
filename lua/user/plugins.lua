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
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "tpope/vim-unimpaired",
  "ray-x/go.nvim",
  "ray-x/guihua.lua",
  "NvChad/nvim-colorizer.lua",
  "ThePrimeagen/vim-be-good",

  -- Custom config
  { "mfussenegger/nvim-jdtls", event = "VeryLazy" },
  { "j-hui/fidget.nvim", config = true },
  { "christianchiarulli/harpoon", config = true, dependencies = { "nvim-telescope/telescope.nvim" } },
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },
  { "junegunn/vim-easy-align", event = "VeryLazy" },
  { "dapc11/vim-fugitive", event = "VeryLazy" },
  { "mfussenegger/nvim-treehopper", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  { "leoluz/nvim-dap-go", config = true },
  { "mfussenegger/nvim-dap-python", event = "VeryLazy" },
  { "cuducos/yaml.nvim", event = "VeryLazy" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = true,
    init = function()
      require("leap").add_default_mappings()
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
  -- { "easymotion/vim-easymotion" },
  { "dapc11/zettelkasten.nvim", ft = "markdown", config = true, opts = { notes_path = "~/notes" } },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
  },
  { "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons" },
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
}
