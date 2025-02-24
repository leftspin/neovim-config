-------------------------------------------------------
-- lua/user/plugin_config/telescope.lua
-------------------------------------------------------
local telescope = require("telescope")
telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    path_display = { "smart" },
    -- any other defaults you want
  },
})

-- Load the fzf extension
pcall(telescope.load_extension, "fzf")
