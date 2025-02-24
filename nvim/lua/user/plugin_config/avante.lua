-------------------------------------------------------
-- lua/user/plugin_config/avante.lua
-------------------------------------------------------
require("render-markdown").setup({
  latex = { enabled = false },
  file_types = { "markdown", "Avante" },
})

require("avante").setup({
  provider = "openai",
  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "o3-mini",
    temperature = 0,
    max_tokens = 4096,
    reasoning_effort = "high",
  },
  windows = {
    sidebar_header = {
      enabled = true,
      align = "center",
      rounded = true,
    },
    ask = {
      floating = false,
      start_insert = true,
      border = "rounded",
      focus_on_apply = "ours",
    },
  },
  mappings = {
    ask = ";a",
    edit = ";e",
    refresh = ";r"
  },
})