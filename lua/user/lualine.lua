local function getLspName()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return "  " .. client.name
		end
	end
	return "  " .. msg
end

lvim.builtin.lualine.on_config_done = function(lualine)
	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {
          "lazygit",
          "TelescopePrompt",
					"help",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"Jaq",
					"harpoon",
					"dap-repl",
					"dap-terminal",
					"dapui_console",
					"startify",
					"lab",
					"Markdown",
					"notify",
					"noice",
					"",
					"dashboard",
					"packer",
					"neo-tree",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
				},
				winbar = {
          "lazygit",
          "TelescopePrompt",
					"help",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"Jaq",
					"harpoon",
					"dap-repl",
					"dap-terminal",
					"dapui_console",
					"startify",
					"lab",
					"Markdown",
					"notify",
					"noice",
					"",
					"dashboard",
					"packer",
					"neo-tree",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
				},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},

		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:gsub(str, "  ")
					end,
				},
				{
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				},
			},
			lualine_b = { "filename", "branch", "diff", "diagnostics" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "encoding", "fileformat", "filetype", "progress", "location" },
			lualine_z = { { getLspName } },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end
