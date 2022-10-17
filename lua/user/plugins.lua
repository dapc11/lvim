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
  "cuducos/yaml.nvim"
}
