-- Additional Plugins
lvim.plugins = {
  "mfussenegger/nvim-jdtls",
  "karb94/neoscroll.nvim",
  "j-hui/fidget.nvim",
  "windwp/nvim-ts-autotag",
  "kylechui/nvim-surround",
  "christianchiarulli/harpoon",
  "lvimuser/lsp-inlayhints.nvim",
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
    "justinmk/vim-sneak",
    requires = { "tpope/vim-repeat" },
  },
  {
    "ggandor/leap.nvim",
    requires = { "tpope/vim-repeat" },
  },
  {
    "ggandor/flit.nvim",
    requires = { "ggandor/leap.nvim" },
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
  "AckslD/nvim-pytrize.lua",
  "tpope/vim-sleuth",
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
  "nvim-orgmode/orgmode",
}
