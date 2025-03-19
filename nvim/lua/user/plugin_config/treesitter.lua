local M = {}

function M.setup()
  local opts = {
    ensure_installed = "all",
    highlight = { enable = true },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      -- Keybindings for treesitter playground are now defined in lua/user/keymaps.lua
      keybindings = require("user.keymaps").treesitter_playground_keybindings,
    },
  }
  
  local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
  if not ts_ok then
    vim.notify("[nvim-treesitter] failed to load configs.", vim.log.levels.ERROR)
    return
  end
  ts_configs.setup(opts)
end

return M