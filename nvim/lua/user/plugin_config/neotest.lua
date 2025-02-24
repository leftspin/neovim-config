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

-- Keymaps to replicate your old TestFile / TestNearest usage
vim.keymap.set("n", "<space>t", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run tests in current file" })

vim.keymap.set("n", "<space>T", function()
  neotest.run.run()
end, { desc = "Run nearest test" })

-- You can add more, e.g. a summary or output panel:
vim.keymap.set("n", "<space>ts", function()
  neotest.run.stop()
end, { desc = "Stop nearest test" })

vim.keymap.set("n", "<space>to", function()
  neotest.output.open({ enter = true })
end, { desc = "Open test output" })
