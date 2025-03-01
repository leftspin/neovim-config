-------------------------------------------------------
-- lua/user/plugin_config/neotest.lua
-- Replaces vim-test with nvim-neotest
-------------------------------------------------------
local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-jest")({
      -- config for jest if needed
      jestCommand = "npm test --",
      jestConfigFile = "jest.config.js",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
    -- add other adapters if needed
  },
})

-- Keymaps moved to keymaps.lua
