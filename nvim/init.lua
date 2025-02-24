-------------------------------------------------------
-- init.lua
-- 1) Bootstraps lazy.nvim
-- 2) Calls lazy.setup with lua/plugins/init.lua
-- 3) Loads user config (settings, keymaps, autocmds, etc.)
-------------------------------------------------------

-- 1) BOOTSTRAP LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2) Load all plugins from lua/plugins/init.lua
require("lazy").setup("plugins")

-- 3) Load user config
require("user.settings")
require("user.keymaps")
require("user.autocmds")
require("user.misc")

-- Plugin-specific configs
require("user.plugin_config.coc")
require("user.plugin_config.avante")
require("user.plugin_config.gutentags")
require("user.plugin_config.neoscroll")
require("user.plugin_config.typecheck")
require("user.plugin_config.telescope")
require("user.plugin_config.neotest")

require("user.plugin_config.gp_commit")
