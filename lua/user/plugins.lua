-- Additional Plugins
lvim.plugins = {
  "mfussenegger/nvim-jdtls",
  "j-hui/fidget.nvim",
  "kylechui/nvim-surround",
  "christianchiarulli/harpoon",
  "kdheepak/lazygit.nvim",
  "junegunn/vim-easy-align",
  {
    "catppuccin/nvim",
    as = "catppuccin",
  },
  "dapc11/vim-fugitive",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "mfussenegger/nvim-treehopper",
  "tpope/vim-unimpaired",
  "ray-x/go.nvim",
  "ray-x/guihua.lua", -- recommanded if need floating window support
  "leoluz/nvim-dap-go",
  "mfussenegger/nvim-dap-python",
  "cuducos/yaml.nvim",
  "dapc11/github-nvim-theme",
  "NvChad/nvim-colorizer.lua",
  {
    "ggandor/leap.nvim",
    requires = { "tpope/vim-repeat" },
  },
  "dapc11/zettelkasten.nvim",
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  },
  "AckslD/nvim-pytrize.lua",
  {
    "danymat/neogen",
    tag = "*",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  "AckslD/swenv.nvim",
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
