-------------------------------------------------------
-- lua/user/misc.lua
-------------------------------------------------------
function _G.SynGroup()
  local pos = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
  local name = vim.fn.synIDattr(pos, "name")
  local trans_name = vim.fn.synIDattr(vim.fn.synIDtrans(pos), "name")
  print(name .. " -> " .. trans_name)
end
vim.keymap.set("n", "\\h", function() SynGroup() end, { silent = true })

function _G.FillLine(str)
  local tw = 80
  local line = vim.api.nvim_get_current_line()
  line = string.gsub(line, "%s*$", "")
  local col = #line
  local reps = math.floor((tw - col) / #str)
  if reps > 0 then
    line = line .. string.rep(str, reps)
    vim.api.nvim_set_current_line(line)
  end
end
vim.keymap.set("n", "<space>-", function() FillLine("_") end, { silent = true })

local function VerticalSplitBuffer(bufnr)
  vim.cmd("vert belowright sb" .. bufnr)
end
vim.api.nvim_create_user_command("Vsb", function(args)
  VerticalSplitBuffer(args.args)
end, { nargs = 1 })

-- "Conflicts" now replaced by a telescope search (see keymaps.lua)