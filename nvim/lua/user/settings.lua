-------------------------------------------------------
-- lua/user/settings.lua
-------------------------------------------------------
local opt = vim.opt
local g = vim.g

-- Shell
opt.shell = "zsh -i"

-- Tabs / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

-- UI
opt.termguicolors = true
opt.laststatus = 2
opt.showmode = false
opt.wrap = true
opt.linebreak = true
opt.list = true
opt.listchars = { tab = "»·", trail = "·" }
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = true
opt.clipboard = "unnamedplus"

-- Guicursor
opt.guicursor =
	"n-v-c:block-Cursor/lCursor-blinkon5000-blinkoff50-blinkwait100,i-ci-cr:Cursor-ver20-blinkon2000-blinkoff50-blinkwait100"

-- Colorscheme
vim.cmd("colorscheme clarity")

-- Neovide
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_refresh_rate = 120
g.neovide_cursor_animation_length = 0.13

-- Lightline
g.lightline = {
	colorscheme = "onedark",
	active = {
		left = {
			{ "mode", "paste" },
			{ "readonly", "gitbranch", "relativepath", "modified" },
		},
	},
	component_function = {
		gitbranch = "FugitiveHead",
	},
}

-- IndentLine
-- g.indentLine_char = '▏'
