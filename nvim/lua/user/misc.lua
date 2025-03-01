-------------------------------------------------------
-- lua/user/misc.lua
-------------------------------------------------------

-- Keymap moved to keymaps.lua

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

-- Keymap moved to keymaps.lua

local function VerticalSplitBuffer(bufnr)
  vim.cmd("vert belowright sb" .. bufnr)
end
vim.api.nvim_create_user_command("Vsb", function(args)
  VerticalSplitBuffer(args.args)
end, { nargs = 1 })

-- set it so vim asks to to throw away a file if the buffer isn't saved instead of just denying you
vim.opt.confirm = true
