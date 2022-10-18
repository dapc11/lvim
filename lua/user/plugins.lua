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
          info = "yellow", error = "red", warning = "orange", hint = "bright_blue"
        },
        overrides = function(c)
          return {
            -- htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
            TelescopeNormal = { fg = c.fg, bg = c.bg },
          }
        end,
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
