local M = {}

function M.setup()
  require("snacks").setup({
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false }, -- Disabled to use built-in statusline
    toggle = {
      which_key = true,
      notify = true,
    },
    words = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        -- { section = "keys", gap = 1, padding = 1 },
        {
          pane = 1,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          padding = 1,
        },
        {
          icon = " ",
          title = "Projects",
          section = "projects",
          padding = 1,
        },
        { section = "startup" },
      },
      -- Keybindings for snacks.nvim are now defined in lua/user/keymaps.lua
    },
  })
end

return M