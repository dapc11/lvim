-- Additional Plugins
lvim.plugins = {
	"mfussenegger/nvim-jdtls",
	{ "j-hui/fidget.nvim", config = true },
	"kylechui/nvim-surround",
	{ "christianchiarulli/harpoon", config = true, dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "kdheepak/lazygit.nvim", cmd = "LazyGit" },
	"junegunn/vim-easy-align",
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	"dapc11/vim-fugitive",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	{
		"mfussenegger/nvim-treehopper",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	"tpope/vim-unimpaired",
	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommanded if need floating window support
	{ "leoluz/nvim-dap-go", config = true },
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
	"NvChad/nvim-colorizer.lua",
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
	},
	{ "dapc11/zettelkasten.nvim", config = true, opts = {
		notes_path = "~/notes",
	} },
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
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	{ "AckslD/nvim-pytrize.lua", config = true },
	{
		"danymat/neogen",
		config = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	"AckslD/swenv.nvim",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
