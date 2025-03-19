-- Define colors from clarity theme
local colors = {
	bg = "#2a4565", -- Main background
	bg_dark = "#102030", -- StatusLine background
	bg_light = "#304E73", -- CursorLine background
	fg = "#a5e9ff", -- Normal foreground
	fg_dark = "#4382CB", -- LineNr foreground
	blue = "#5fa1db", -- Statement
	green = "#70d080", -- Identifier
	yellow = "#ecad2b", -- Constant/Number
	orange = "#fb5baa", -- String
	purple = "#8f9ae5", -- Comment
	cyan = "#8cd0d3", -- Type
	red = "#FF6347", -- DiagnosticError
	gray = "#8090a0", -- Delimiter
}

-- Setup lualine with custom theme
require("lualine").setup({
	options = {
		theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = "#332b15", fg = colors.yellow }, -- Dark orange tint for path section
				c = { bg = colors.bg, fg = colors.fg },
				x = { bg = colors.bg, fg = colors.fg },
				y = { bg = "#1a2e1a", fg = colors.green }, -- Dark green tint for progress
				z = { bg = "#1a2a33", fg = colors.cyan }, -- Dark cyan tint for location
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = "#332b15", fg = colors.yellow },
				y = { bg = "#1a2e1a", fg = colors.green },
				z = { bg = "#1a2a33", fg = colors.cyan },
			},
			visual = {
				a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
				b = { bg = "#332b15", fg = colors.yellow },
				y = { bg = "#1a2e1a", fg = colors.green },
				z = { bg = "#1a2a33", fg = colors.cyan },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = "#332b15", fg = colors.yellow },
				y = { bg = "#1a2e1a", fg = colors.green },
				z = { bg = "#1a2a33", fg = colors.cyan },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = "#332b15", fg = colors.yellow },
				y = { bg = "#1a2e1a", fg = colors.green },
				z = { bg = "#1a2a33", fg = colors.cyan },
			},
			inactive = {
				a = { bg = colors.bg, fg = colors.fg_dark, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg_dark }, -- Subdued color for inactive path
				c = { bg = colors.bg, fg = colors.fg_dark },
				x = { bg = colors.bg, fg = colors.fg_dark },
				y = { bg = colors.bg, fg = colors.fg_dark },
				z = { bg = colors.bg, fg = colors.fg_dark },
			},
		},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			-- Custom function to show CWD + path + filename with modified/readonly indicators
			{
				function()
					local cwd = vim.fn.getcwd()
					local path = vim.fn.expand("%:p")
					-- Extract relative path from the current working directory
					local rel_path = path:gsub(vim.fn.getcwd() .. "/", "")

					-- Add modified/readonly indicators
					local modified = ""
					if vim.bo.modified then
						modified = " \u{EADE} "
					end
					local readonly = ""
					if vim.bo.readonly then
						readonly = " \u{E0A2} "
					end

					return cwd .. " \u{F178}  " .. rel_path .. modified .. readonly
				end,
				color = { fg = colors.yellow },
				padding = { left = 1, right = 1 },
			},
		},
		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " \u{EA87} ", warn = " \u{F071} ", info = " \u{F449} ", hint = " \u{F400} " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.blue },
					hint = { fg = colors.cyan },
				},
			},
		},
		lualine_x = {
			{ "encoding" },
			{
				"fileformat",
				icons_enabled = true,
			},
			{ "filetype", icon_only = false, padding = { left = 1, right = 1 } },
		},
		lualine_y = {
			{
				"progress",
				icon = "     ",
				padding = { left = 1, right = 1 },
				color = { fg = colors.green },
			},
		},
		lualine_z = {
			{ "location", icon = "󰍎", padding = { left = 1, right = 1 }, color = { fg = colors.cyan } },
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
			-- Show path in inactive buffers too
			{
				function()
					local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					local path = vim.fn.expand("%:p")
					-- Extract relative path from the current working directory
					local rel_path = path:gsub(vim.fn.getcwd() .. "/", "")
					return cwd .. " ▶ " .. rel_path
				end,
			},
		},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})

return {}
