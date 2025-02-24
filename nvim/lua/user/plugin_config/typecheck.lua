-------------------------------------------------------
-- lua/user/plugin_config/typecheck.lua
-------------------------------------------------------
local issues = {}

local function removeAnsiEscapeCodes(str)
  return string.gsub(str, "\x1b%[%d+%m", "")
end

local function handleOutput(job_id, data, event)
  if event == "stdout" or event == "stderr" then
    for _, line in ipairs(data) do
      local clean_line = removeAnsiEscapeCodes(line)
      local file, lnum, col, code, msg =
        string.match(clean_line, "^(.*):(%d+):(%d+)%s+%-%s+error%s+(%w+):%s+(.*)$")
      if file then
        table.insert(issues, {
          filename = file,
          lnum = tonumber(lnum),
          col = tonumber(col),
          text = code .. ": " .. msg,
          type = "E"
        })
      end
    end
  elseif event == "exit" then
    vim.fn.setqflist({})
    vim.fn.setqflist(issues)
    issues = {}
    vim.notify("Typecheck complete", vim.log.levels.INFO)
  end
end

function _G.TypeCheck(open_quickfix, async)
  local cmd = { "npx", "tsc", "--noEmit", "--pretty", "--noErrorTruncation" }

  if async then
    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      on_stdout = handleOutput,
      on_stderr = handleOutput,
      on_exit = handleOutput,
    })
  else
    local result = vim.fn.systemlist(table.concat(cmd, " "))
    handleOutput(0, result, "stdout")
    handleOutput(0, {}, "exit")
  end

  if open_quickfix then
    vim.cmd("copen")
  end
end

-- Create :Tsc command
vim.api.nvim_create_user_command("Tsc", function()
  TypeCheck(true, false)
end, {})

-- Auto-run TypeCheck on BufWritePost (async)
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    TypeCheck(false, true)
  end
})
