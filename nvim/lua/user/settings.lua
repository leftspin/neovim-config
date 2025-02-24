-------------------------------------------------------
-- lua/user/settings.lua
-------------------------------------------------------
local opt = vim.opt
local g   = vim.g

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
opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon5000-blinkoff50-blinkwait100,i-ci-cr:Cursor-ver20-blinkon2000-blinkoff50-blinkwait100"

-- Colorscheme
vim.cmd("colorscheme clarity")

-- Neovide
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_refresh_rate = 120
g.neovide_cursor_animation_length = 0.13

-- Lightline
g.lightline = {
  colorscheme = 'onedark',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'readonly', 'gitbranch', 'relativepath', 'coc', 'gutentags', 'modified' }
    }
  },
  component_function = {
    gitbranch = 'FugitiveHead',
    gutentags = 'gutentags#statusline',
    coc       = 'StatusDiagnostic'
  },
}

-- Startify
g.startify_change_to_dir = 0
g.startify_change_to_vcs_root = 1
g.startify_session_delete_buffers = 1
g.startify_session_persistence = 1
g.startify_enable_special = 1

-- Blamer
g.blamer_enabled = 1
g.blamer_show_in_visual_modes = 0
g.blamer_prefix = " ◼︎ "

-- GitHub Enterprise
g.github_enterprise_urls = { "https://github.cbhq.net" }

-- IndentLine
g.indentLine_char = '▏'

-- Copilot (vim plugin) no tab override
g.copilot_no_tab_map = true
