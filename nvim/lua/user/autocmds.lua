-------------------------------------------------------
-- lua/user/autocmds.lua
-------------------------------------------------------
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Syntax sync for JS/TS
autocmd("BufEnter", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.cmd("syntax sync fromstart")
  end,
})
autocmd("BufLeave", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.cmd("syntax sync clear")
  end,
})

-- Filetype detection for .ts, .tsx, .jsx
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ts" },
  callback = function()
    vim.bo.filetype = "typescript"
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tsx", "*.jsx" },
  callback = function()
    vim.bo.filetype = "typescript.tsx"
  end,
})

-- CursorLine only in active window
augroup("CursorLineOnlyInActiveWindow", { clear = true })
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = "CursorLineOnlyInActiveWindow",
  callback = function()
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
  end,
})
autocmd("WinLeave", {
  group = "CursorLineOnlyInActiveWindow",
  callback = function()
    vim.opt.cursorline = false
    vim.opt.cursorcolumn = false
  end,
})

-- Number toggle
augroup("numbertoggle", { clear = true })
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = "numbertoggle",
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})
autocmd("WinLeave", {
  group = "numbertoggle",
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- OSCYank
autocmd("TextYankPost", {
  callback = function()
    vim.cmd("OSCYankRegister " .. vim.v.event.regname)
  end,
})

-- Watchbuild with Coc
augroup("coc_watchbuild", { clear = true })
autocmd("User", {
  pattern = "CocNvimInit",
  group = "coc_watchbuild",
  callback = function()
    vim.fn.CocAction("runCommand", "tsserver.watchBuild")
  end,
})
