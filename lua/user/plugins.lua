-- Additional Plugins
lvim.plugins = {
  "mfussenegger/nvim-jdtls",
  "karb94/neoscroll.nvim",
  "j-hui/fidget.nvim",
  "windwp/nvim-ts-autotag",
  "kylechui/nvim-surround",
  "christianchiarulli/harpoon",
  "windwp/nvim-spectre",
  "lvimuser/lsp-inlayhints.nvim",
  "kdheepak/lazygit.nvim",
  "junegunn/vim-easy-align",
  {
    "catppuccin/nvim",
    as = "catppuccin",
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
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
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  "mfussenegger/nvim-dap-python",
  "cuducos/yaml.nvim",
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        theme_style = "dark",
        colors = {
          blue = "#539bf5",
          green = "#57ab5a",
          red = "#f47067",
          info = "#539bf5",
          error = "#f47067",
          warning = "#d18616",
          hint = "#6cb6ff",
          git = {
            add = "#57ab5a",
            change = "#daaa3f",
            delete = "#f47067",
            conflict = "#daaa3f",
            ignore = "#545d68",
          },
          git_signs = {
            add = "#57ab5a",
            change = "#daaa3f",
            delete = "#f47067",
          },
        },
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
}
