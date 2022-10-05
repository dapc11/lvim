lvim.lsp.installer.setup.ensure_installed = {
	"sumeko_lua",
	"jsonls",
	"pyright",
	"gopls",
}

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", filetypes = { "python" } },
	{ command = "isort", filetypes = { "python" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "gofmt", filetypes = { "go" } },
	{ command = "goimports", filetypes = { "go" } },
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "pylint",
		filetypes = { "python" },
		extra_args = {
			"-d",
			"R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309",
		},
	},
	{
		command = "flake8",
		filetypes = { "python" },
		extra_args = {
			"--per-file-ignores=**/test_*:D100,D103",
		},
	},
	{ command = "golangci_lint", filetypes = { "go" } },
})
