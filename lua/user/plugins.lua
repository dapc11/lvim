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
  {
    "mfussenegger/nvim-treehopper",
    config = function()
      vim.cmd([[
          omap <silent> m :<C-U>lua require('tsht').nodes()<CR>
          xnoremap <silent> m :lua require('tsht').nodes()<CR>
        ]])
    end,
  },
  "tpope/vim-unimpaired",
  "ray-x/go.nvim",
  "ray-x/guihua.lua", -- recommanded if need floating window support
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
  },
  "mfussenegger/nvim-dap-python",
  "cuducos/yaml.nvim",
  {
    "dapc11/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        theme_style = "dark",
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "virtualtext", -- Set the display mode.
          virtualtext = "■■■■■",
        },
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    requires = { "tpope/vim-repeat" },
  },
  {
    "ggandor/flit.nvim",
    requires = { "ggandor/leap.nvim" },
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        labeled_modes = "v",
        multiline = true,
        opts = {},
      })
    end,
  },
  {
    "dapc11/zettelkasten.nvim",
    config = function()
      require("zettelkasten").setup({
        notes_path = "~/notes",
      })
    end,
  },
}
