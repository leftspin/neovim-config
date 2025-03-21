-------------------------------------------------------
-- lua/user/plugin_config/avante.lua
-------------------------------------------------------
require("render-markdown").setup({
  latex = { enabled = false },
  file_types = { "markdown", "Avante" },
})

require("avante").setup({

  provider = "claude",

  claude = {
    disable_tools = true,
  },

  ["openai"] = {
    endpoint = "https://api.openai.com/v1",
    model = "o3-mini",
    reasoning_effort = "high",
    temperature = 0,
    max_tokens = 8912,
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
    refresh = ";r",
  },
})
