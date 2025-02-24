-------------------------------------------------------
-- lua/user/plugin_config/coc.lua
-------------------------------------------------------
local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 then return true end
  local line = vim.fn.getline(".")
  return string.match(line:sub(col, col), "%s") ~= nil
end

-- Tab completion
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif check_back_space() then
    return "<Tab>"
  else
    return vim.fn["coc#refresh"]()
  end
end, { expr = true, silent = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<C-h>"
  end
end, { expr = true, silent = true })

-- Show documentation
local function show_documentation()
  if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
    vim.cmd("help " .. vim.fn.expand("<cword>"))
  else
    vim.fn.CocActionAsync("doHover")
  end
end
vim.keymap.set("n", "K", show_documentation, { silent = true })

-- Lightline integration
function _G.StatusDiagnostic()
  local info = vim.b.coc_diagnostic_info or {}
  if next(info) == nil then
    return ""
  end
  local msgs = {}
  if info.error and info.error > 0 then
    table.insert(msgs, info.error .. " Errors")
  end
  if info.warning and info.warning > 0 then
    table.insert(msgs, info.warning .. " Warnings")
  end
  return table.concat(msgs, " ")
end

-- Coc recommended mappings
vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.keymap.set("n", "<leader>rn", ":CocCommand document.renameCurrentWord<CR>", { silent = true })

-- Format selected
vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Code actions
vim.keymap.set("n", "<space>ac", "<Plug>(coc-codeaction)", { silent = true })
vim.keymap.set("n", "<space>qf", "<Plug>(coc-fix-current)", { silent = true })
