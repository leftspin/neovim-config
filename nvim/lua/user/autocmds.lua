-------------------------------------------------------
-- lua/user/autocmds.lua
-------------------------------------------------------
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- OSCYank
autocmd("TextYankPost", {
  callback = function()
    vim.cmd("OSCYankRegister " .. vim.v.event.regname)
  end,
})
